-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.globals.values end
-- import Raids.globals.RaidItems end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.sapp.PlayerEvents.Commands.ChangePlayerClass end
-- import Raids.modules.Balancer.RaidBalancer end
-- END_IMPORT


function loadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new():create(playerIndex)
    local playerClass = newPlayer:getPreferredClass()
    --step two: initalize values, load player
    ACTIVE_PLAYER_LIST[hash] = newPlayer
    if playerClass ~= "dps" then playerClass = "dps" end
    changePlayerClass(playerIndex, playerClass)
    Balancer()
end