-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Player end
-- import Raids.sapp.Loaders.LoadBipeds end
-- import Raids.sapp.PlayerEvents.LoadPlayer end
-- import Raids.sapp.PlayerEvents.UnloadPlayer end
-- import Raids.sapp.PlayerEvents.ParseCommand end
-- import Raids.util.FindBipedTag end
-- import Raids.modules.Events.EventItem end
-- import Raids.modules.Events.EventTable end
-- import Raids.gameplay.BossMechanics.HealthBar end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.util.ModifyDamage end
-- import Raids.modules.io.WritePlayerToFile end
-- END_IMPORT


--Callbacks

function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    register_callback(cb['EVENT_JOIN'], "handleJoin")
    register_callback(cb['EVENT_LEAVE'], "handleLeave")
    register_callback(cb['EVENT_DAMAGE_APPLICATION'], "handleDamage")
    register_callback(cb['EVENT_OBJECT_SPAWN'], "handleObjectSpawn")
    register_callback(cb['EVENT_SPAWN'], "handleSpawn")
    register_callback(cb['EVENT_TICK'], "handleTick")
    register_callback(cb['EVENT_DIE'], "handlePlayerDie")
    register_callback(cb['EVENT_AREA_ENTER'], "handleAreaEnter")
    register_callback(cb['EVENT_AREA_EXIT'], "handleAreaExit")
    register_callback(cb['EVENT_PRESPAWN'], "handlePrespawn")
    register_callback(cb['EVENT_GAME_END'],"OnGameEnd")
    register_callback(cb['EVENT_GAME_START'], "OnGameStart")
    for i=0,16 do
        if player_present(i) then
            loadPlayer(i)
            kill(i)
        end
    end
end

function OnScriptUnload()
    -- unregister_callback(cb['EVENT_COMMAND'])
    -- unregister_callback(cb['EVENT_JOIN'])
    -- unregister_callback(cb['EVENT_LEAVE'])
    -- unregister_callback(cb['EVENT_DAMAGE_APPLICATION'])
    -- unregister_callback(cb['EVENT_OBJECT_SPAWN'])
    -- unregister_callback(cb['EVENT_TICK'])
    -- unregister_callback(cb['EVENT_DIE'])
    -- unregister_callback(cb['EVENT_AREA_ENTER'])
    -- unregister_callback(cb['EVENT_AREA_EXIT'])
    -- unregister_callback(cb['EVENT_PRESPAWN'])
    -- unregister_callback(cb['EVENT_GAME_END'])
    -- unregister_callback(cb['EVENT_GAME_START'])
    -- for i=0,16 do
    --     if player_present(i) then
    --         WritePlayerToFile(get_var(i, "$hash"))
    --     end
    -- end
    BIPED_TAG_LIST = {}
    ACTIVE_PLAYER_LIST = {}
    ACTIVE_BOSSES = {}
    EVENT_TABLE = {}
end

OnGameStart = OnScriptLoad

OnGameEnd = OnScriptUnload

function handleAreaEnter(playerIndex, areaEntered) 
    if player_present(playerIndex) then
        local hash = get_var(playerIndex, "$hash")
        local player = ACTIVE_PLAYER_LIST[hash]
        say(playerIndex, "You approach " .. LOCATIONS[areaEntered])
        player:setLocation(areaEntered)
    end
end

function handleAreaExit(playerIndex, areaExited) 
    if player_present(playerIndex) then 
        local hash = get_var(playerIndex, "$hash")
        local player = ACTIVE_PLAYER_LIST[hash]
        say(playerIndex, "You walk away from " .. LOCATIONS[areaExited])
        player:removeLocation(areaExited)
    end
end

--TODO: Dequeue ultimate if player dies
function handlePlayerDie(playerIndex, causer)
    if(player_present(playerIndex)) then
        local hash = get_var(playerIndex, "$hash")
        local playerClass = ACTIVE_PLAYER_LIST[hash]
        if playerClass:getClass():getClassName() == "boss" or ACTIVE_BOSSES[playerIndex] ~= nil then
            ACTIVE_BOSSES[playerIndex] = nil
            playerClass:setArmor(nil, "DEFAULT")
        end
    end
end

function handleDamage(playerIndex, damagerPlayerIndex, damageTagId, Damage, CollisionMaterial, Backtap)
    --TODO: Refactor this into a damage function, that funnels through all players and handles damage accordingly. 
    local attackingPlayer = ACTIVE_PLAYER_LIST[get_var(damagerPlayerIndex, "$hash")]
    local damagedPlayer = ACTIVE_PLAYER_LIST[get_var(damagerPlayerIndex, "$hash")]
    if player_present(playerIndex) and player_present(damagerPlayerIndex) then
        local newDamage = Damage
        if attackingPlayer:getEquipment() ~= nil then  
            newDamage = math.max(newDamage, attackingPlayer:getEquipment():computeNewDamage(Damage)) 
        end
        if damagedPlayer:getEquipment() ~= nil then 
            newDamage = math.min(newDamage, damagedPlayer:getEquipment():computeNewDamage(Damage))
        end
        newDamage = newDamage - damagedPlayer:getArmor():getDefense()
        if newDamage <= 0 then newDamage = 1 end
        if playerIndex == damagerPlayerIndex then 
            say(playerIndex, "You dealt " .. newDamage .. " damage to yourself, you goober!")
        else
            say(playerIndex, "You were dealt " .. newDamage .. " damage!")
            say(damagerPlayerIndex, "You dealt " .. newDamage .. " damage!")
        end
        return true,newDamage
    end
    return true
end

function handleTick()
    PrintBossBar()
    EventTable:cycle()
end

function handleObjectSpawn(playerIndex, tagId, parentObjectId, newObjectId)
    if BIPED_TAG_LIST['DEFAULT'] == nil then 
        loadBipeds() 
    end
    if player_present(playerIndex) and tagId == BIPED_TAG_LIST['DEFAULT'] then 
        local hash = get_var(playerIndex, "$hash")
        local currentPlayer = ACTIVE_PLAYER_LIST[hash]
        local playerGuard = get_dynamic_player(playerIndex)
        if playerGuard ~= 0 then
            write_float(playerGuard + 0xD8, currentPlayer:getArmor():getMaxHealth())
        end
        return true,BIPED_TAG_LIST[currentPlayer:getArmor():getName()]
    end
end


function handlePrespawn(playerIndex)
    if player_present(playerIndex) then
        local hash = get_var(playerIndex, "$hash")
        if ACTIVE_PLAYER_LIST[hash]:getClass():getClassName() == "boss" then
            execute_command("t ".. tostring(playerIndex) .." ".. tostring(ACTIVE_PLAYER_LIST[hash]:getArmor():getName()))
        end
    end
end

function handleSpawn(playerIndex)
    local hash = get_var(playerIndex, "$hash")
    local currentPlayer = ACTIVE_PLAYER_LIST[hash]
    if currentPlayer:getClass():getClassName() ~= "boss" then
        execute_command('wdel ' .. playerIndex .. ' 5')
    end
    if currentPlayer:getSecondaryWeapon() ~= nil then
        assign_weapon(spawn_object("weap", currentPlayer:getSecondaryWeapon():getRef()), tonumber(playerIndex))
    end
    if currentPlayer:getPrimaryWeapon() ~= nil then
        assign_weapon(spawn_object("weap", currentPlayer:getPrimaryWeapon():getRef()), tonumber(playerIndex))
    end
end


function handleJoin(playerIndex) 
    if player_present(playerIndex) then
        loadPlayer(playerIndex)
    end
end


function handleLeave(playerIndex) 
    if player_present(playerIndex) then
        unloadPlayer(playerIndex)
    end
end


function handleCommand(playerIndex, Command, Env, RconPassword ) --number, string, number, string
    if player_present(playerIndex) then
        if parseCommand(playerIndex, Command) == true then return false end
    end
end