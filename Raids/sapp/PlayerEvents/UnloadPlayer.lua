-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.modules.Balancer.RaidBalancer end
-- import Raids.modules.io.WritePlayerToFile end
-- END_IMPORT



function unloadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    WritePlayerToFile(hash)
    ACTIVE_PLAYER_LIST[hash] = nil
    Balancer()
end
