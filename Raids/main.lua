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
-- import Raids.sapp.PlayerEvents.ActivateUltimateAbility end
-- import Raids.gameplay.BossEvents.PlaySound end
-- import Raids.globals.Dialog end
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
    -- BIPED_TAG_LIST = {}
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
            local bossName = playerClass:getArmor():getName()
            local lootEvent = EventItem:new()
            lootEvent:set({BOSS=bossName}, nil, rewardLoot, 30 * 10)
            EventTable:addEvent(bossName, lootEvent)
            ACTIVE_BOSSES[playerIndex] = nil
            playerClass:setArmor(nil, "DEFAULT")
            playDialog(bossName, "death")
            for i=0,16 do
                if player_present(i) then
                    ACTIVE_PLAYER_LIST[get_var(i, "$hash")]:resetDamage()
                end
            end
        end
    end
end

function handleDamage(damagedPlayerIndex, attackingPlayerIndex, damageTagId, Damage, CollisionMaterial, Backtap)
    --TODO: Refactor this into a damage function, that funnels through all players and handles damage accordingly. 
    local attackingPlayer = ACTIVE_PLAYER_LIST[get_var(attackingPlayerIndex, "$hash")]
    local damagedPlayer = ACTIVE_PLAYER_LIST[get_var(damagedPlayerIndex, "$hash")]
    if player_present(damagedPlayerIndex) and player_present(attackingPlayerIndex) then
        if attackingPlayer:getClass():getClassName() == "healer" and damagedPlayer:getClass():getClassName() ~= "boss" then
            local damagedPlayerInMemory = get_dynamic_player(damagedPlayerIndex) 
            if damagedPlayerInMemory ~= 0 then
                local maxPlayerHealth = damagedPlayer:getArmor():getMaxHealth()
                local currentPlayerHealth = read_float(damagedPlayerInMemory + 0xE0)*maxPlayerHealth
                local fraction = currentPlayerHealth / maxPlayerHealth
                if fraction <= 1.10 then
                    execute_command("hp " .. damagedPlayerIndex .. " " .. fraction + 0.05)
                end
            end
            return true,0
        else
            local newDamage = Damage
            if attackingPlayer:getEquipment() ~= nil then  
                newDamage = math.max(newDamage, attackingPlayer:getEquipment():computeNewDamage(Damage)) 
            end
            if damagedPlayer:getEquipment() ~= nil then 
                newDamage = math.min(newDamage, damagedPlayer:getEquipment():computeNewDamage(Damage))
            end
            newDamage = newDamage - damagedPlayer:getArmor():getDefense()
            if newDamage <= 0 then newDamage = 1 end
            if damagedPlayerIndex == attackingPlayerIndex then 
                say(damagedPlayerIndex, "You dealt " .. newDamage .. " damage to yourself, you goober!")
            else
                say(damagedPlayerIndex, "You were dealt " .. newDamage .. " damage!")
                say(attackingPlayerIndex, "You dealt " .. newDamage .. " damage!")
            end
            if damagedPlayer:getClass():getClassName() == "boss" and attackingPlayer:getClass():getClassName() ~= "boss" then
                attackingPlayer:addDamage(newDamage)
            end
            return true,newDamage
        end
    end
    return true
end

function handleTick()
    for i = 0,16 do
        if player_present(i) and player_alive(i) then
            local test = read_bit(get_dynamic_player(i) + 0x208, 4)
            if test ~= nil and test == 1 then
                local activateUltEvent = EventItem:new()
                activateUltEvent:set(
                    {['playerIndex']=i, ['hash']=get_var(i, "$hash")}, 
                    nil, 
                    function(props)  activateUltimateAbility(props.hash, props.playerIndex) end,
                    0
                )
                EventTable:addEvent('PLAYER_' .. i .. '_ULT_ACTIVATE', activateUltEvent)
            end
        end
    end
    PrintBossBar()
    EventTable:cycle()
end

function handleObjectSpawn(playerIndex, tagId, parentObjectId, newObjectId)
    if BIPED_TAG_LIST['DEFAULT'] == nil then 
        loadBipeds() 
    end
    local bossCount = 0
    if player_present(playerIndex) and tagId == BIPED_TAG_LIST['DEFAULT'] then 
        local hash = get_var(playerIndex, "$hash")
        local currentPlayer = ACTIVE_PLAYER_LIST[hash]
        return true,BIPED_TAG_LIST[currentPlayer:getArmor():getName()]
    end
end


function handlePrespawn(playerIndex)
    if player_present(playerIndex) then
        local hash = get_var(playerIndex, "$hash")
        if ACTIVE_PLAYER_LIST[hash]:getClass():getClassName() == "boss" then
            execute_command("t ".. tostring(playerIndex) .." ".. tostring(ACTIVE_PLAYER_LIST[hash]:getArmor():getName()))
            return
        end
        local bossCount = 0
        for k,v in pairs(ACTIVE_BOSSES) do
            bossCount = bossCount + 1 
        end
        if bossCount > 0 then
            execute_command("t " .. tostring(playerIndex) .. " timeout")
        end
    end
end

function handleSpawn(playerIndex)
    local hash = get_var(playerIndex, "$hash")
    local currentPlayer = ACTIVE_PLAYER_LIST[hash]
    local playerGuard = get_dynamic_player(playerIndex)
    if playerGuard ~= 0 then
        write_float(playerGuard + 0xD8, currentPlayer:getArmor():getMaxHealth())
    end
    if currentPlayer:getClass():getClassName() ~= "boss" then
        execute_command('wdel ' .. playerIndex .. ' 5')
    else
        playDialog(currentPlayer:getArmor():getName(), 'spawn')
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