-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Player end
-- import Raids.sapp.Loaders.LoadBipeds end
-- import Raids.sapp.PlayerEvents.LoadPlayer end
-- import Raids.sapp.PlayerEvents.UnloadPlayer end
-- import Raids.sapp.PlayerEvents.ParseCommand end
-- import Raids.util.FindBipedTag end
-- import Raids.modules.Events.EventItem end
-- import Raids.gameplay.BossMechanics.HealthBar end
-- END_IMPORT


--Callbacks
function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    register_callback(cb['EVENT_JOIN'], "handleJoin")
    register_callback(cb['EVENT_LEAVE'], "handleLeave")
    register_callback(cb['EVENT_DAMAGE_APPLICATION'], "handleDamage")
    register_callback(cb['EVENT_OBJECT_SPAWN'], "handleSpawn")
    register_callback(cb['EVENT_TICK'], "handleTick")
    register_callback(cb['EVENT_DIE'], "handlePlayerDie")
end


function OnScriptUnload()

end

function handlePlayerDie(playerIndex, causer)
    ACTIVE_BOSSES[playerIndex] = nil

end

function handleDamage(playerIndex, damagerPlayerIndex, damageTagId, Damage, CollisionMaterial, Backtap) 
    if player_present(playerIndex) then
        say(playerIndex, "You are taking " .. Damage .. " from player with index " .. damagerPlayerIndex)
        say(damagerPlayerIndex, "You are dealing " .. Damage .. " to player with index " .. playerIndex)
    end
end

function handleTick()
    PrintBossBar()
    for key,_ in pairs(EVENT_TABLE) do
        if EVENT_TABLE[key]:isTimedOut() == true then
            EVENT_TABLE[key] = nil 
        end
    end

end

function handleSpawn(playerIndex, tagId, parentObjectId, newObjectId)
    if BIPED_TAG_LIST['DEFAULT'] == nil then 
        loadBipeds() 
    end
    if player_present(playerIndex) and tagId == BIPED_TAG_LIST['DEFAULT'] then 
        local hash = get_var(playerIndex, "$hash")
        local currentPlayer = ACTIVE_PLAYER_LIST[hash]
        local maxHealth = currentPlayer:getClass().maxHealth
        print(maxHealth)
        if maxHealth ~= nil and maxHealth ~= 0 then
            local playerGuard = get_dynamic_player(playerIndex)
            if playerGuard ~= 0 then
                write_float(playerGuard + 0xD8, maxHealth)
            end
        else
            print("SOMETHING WENT WRONG WHEN TRYING TO OVERWRITE PLAYER'S HEALTH!")
        end
        return true,BIPED_TAG_LIST[currentPlayer:getClass().name]
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