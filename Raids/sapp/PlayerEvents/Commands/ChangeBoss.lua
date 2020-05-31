-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Boss end
-- import Raids.classes.Player end
-- import Raids.globals.values end
-- import Raids.modules.Events.EventItem end
-- import Raids.modules.Events.EventTable end
-- import Raids.gameplay.BossEvents.Torres end
-- END_IMPORT

function changeBoss(playerIndex, player, selectedBoss)
    if BIPED_TAG_LIST[selectedBoss] ~= nil then
        kill(playerIndex)
        local playerClass = player:getClass()
        player:setBoss(selectedBoss)
        ACTIVE_BOSSES[playerIndex] = player
        --TODO: Refactor this so that it can handle all bosses. 
        --probably best to place this in one function.
        if selectedBoss == "torres" then
            newTorresEvent = EventItem:new()
            newTorresEvent:set({}, nil, NotifyPlayersCompleted, 30 * 26)
            EventTable:addEvent('TorresEvent', newTorresEvent)
        end
    else
        say(playerIndex, "That boss does not exist!")
    end
end