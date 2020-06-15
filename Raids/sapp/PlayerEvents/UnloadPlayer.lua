-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.modules.Balancer.RaidBalancer end
-- END_IMPORT



function unloadPlayer(playerIndex)
    local hash = get_var(playerIndex, "$hash")
    ACTIVE_PLAYER_LIST[hash]:delete() 
    ACTIVE_PLAYER_LIST[hash] = nil
    Balancer()
end
