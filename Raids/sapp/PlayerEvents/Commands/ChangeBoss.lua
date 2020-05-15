-- BEGIN_IMPORT
-- import Raids.classes.Boss end
-- import Raids.classes.Player end
-- import Raids.globals.values end
-- END_IMPORT

function changeBoss(playerIndex, player, selectedBoss)
    if BIPED_TAG_LIST[selectedBoss] ~= nil then
        kill(playerIndex)
        local playerClass = player:getClass()
        playerClass:changeBoss(selectedBoss)
        ACTIVE_BOSSES[playerIndex] = player
    else
        say(playerIndex, "That boss does not exist!")
    end
end