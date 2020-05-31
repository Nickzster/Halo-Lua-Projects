-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.globals.values end
-- import Raids.globals.RaidItems end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.sapp.PlayerEvents.Commands.ChangePlayerClass end
-- import Raids.modules.io.ReadPlayerFromFile end
-- END_IMPORT


function loadPlayer(playerIndex) 
    local playerClass = 'dps'
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new()
    newPlayer:setPlayerIndex(playerIndex)
    local playerData = ReadPlayerFromFile(hash, playerIndex)
    if playerData ~= nil then
        print("Reading in player!")
        newPlayer = playerData
        playerClass = newPlayer:getPreferredClass()
        newPlayer:setPlayerIndex(playerIndex)
    else
        print(newPlayer)
        print("Setting up new player!")
        newPlayer:setUpNewPlayer()
    end
    --step two: initalize values, load player
    ACTIVE_PLAYER_LIST[hash] = newPlayer
    changePlayerClass(playerIndex, playerClass)
end