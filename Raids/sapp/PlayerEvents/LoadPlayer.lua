-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.classes.Dps end
-- import Raids.globals.values end
-- END_IMPORT

function loadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new()
    newPlayer:setClass(DpsSchema:new())
    ACTIVE_PLAYER_LIST[hash] = newPlayer
end