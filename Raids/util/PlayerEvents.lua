-- BEGIN_IMPORT
-- import Raids.classes.Schemas.Player end
-- import Raids.classes.functions end
-- import Raids.globals.values end
-- END_IMPORT

function loadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new()
    newPlayer:setClass(CLASS_LIST["dps"]:new())
    ACTIVE_PLAYER_LIST[hash] = newPlayer
end

function changePlayerClass(playerIndex, newClass)
    kill(playerIndex)
    ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]:setClass(CLASS_LIST[newClass]:new())
end



function unloadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    ACTIVE_PLAYER_LIST[hash] = nil
end

