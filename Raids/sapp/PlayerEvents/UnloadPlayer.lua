-- BEGIN_IMPORT
-- import Raids.globals.values end
-- END_IMPORT

function unloadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    ACTIVE_PLAYER_LIST[hash] = nil
end
