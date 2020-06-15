-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.globals.values end
-- import Raids.globals.RaidItems end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.sapp.PlayerEvents.Commands.ChangePlayerClass end
-- import Raids.modules.Balancer.RaidBalancer end
-- END_IMPORT


function loadPlayer(playerIndex) 
    local playerClass = 'dps'
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new():create(playerIndex)
    --step two: initalize values, load player
    ACTIVE_PLAYER_LIST[hash] = newPlayer
    if playerClass ~= "dps" and playerClass ~= "gunslinger" then
        playerClass = "dps"
    end
    changePlayerClass(playerIndex, playerClass)
    Balancer()
end