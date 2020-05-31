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
    local newPlayer = PlayerSchema:new():loadPlayer()
    print("\n\n=========================================================")
    print(get_var(playerIndex, "$name") .. ' has joined the server!\n')
    newPlayer:setPlayerIndex(playerIndex)
    local playerData = ReadPlayerFromFile(hash, playerIndex)
    if playerData ~= nil then
        print(get_var(playerIndex, "$name") .. " has a file on record!")
        newPlayer = playerData
        playerClass = newPlayer:getPreferredClass()
        newPlayer:setPlayerIndex(playerIndex)
    else
        print(get_var(playerIndex, "$name") .. " is a new player!")
        newPlayer:setUpNewPlayer()
    end
    print("=========================================================\n\n")
    --step two: initalize values, load player
    ACTIVE_PLAYER_LIST[hash] = newPlayer
    changePlayerClass(playerIndex, playerClass)
end