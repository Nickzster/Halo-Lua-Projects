-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.functions end
-- import Raids.util.LoadTags end
-- import Raids.util.PlayerEvents end
-- import Raids.modules.ParseCommand end
-- import Raids.util.FindBipedTag end
-- import Raids.modules.EventQueue.EventTable end
-- END_IMPORT


--Callbacks
function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    register_callback(cb['EVENT_JOIN'], "handleJoin")
    register_callback(cb['EVENT_LEAVE'], "handleLeave")
    register_callback(cb['EVENT_DAMAGE_APPLICATION'], "handleDamage")
    register_callback(cb['EVENT_OBJECT_SPAWN'], "handleSpawn")
    register_callback(cb['EVENT_TICK'], "handleTick")
end


function OnScriptUnload()

end

function handleDamage(playerIndex, damagerPlayerIndex, damageTagId, Damage, CollisionMaterial, Backtap) end

function handleTick()
    for key,_ in pairs(EVENT_TABLE) do
        if EVENT_TABLE[key]:isTimedOut() == true then
            EVENT_TABLE[key]:execute()
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
        return true,BIPED_TAG_LIST[ACTIVE_PLAYER_LIST[hash]:getClass().name]
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