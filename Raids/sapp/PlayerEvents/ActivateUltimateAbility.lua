-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.classes.Dps end
-- import Raids.classes.Healer end
-- import Raids.classes.Tank end
-- import Raids.classes.Bandolier end
-- import Raids.classes.Gunslinger end
-- import Raids.globals.values end
-- import Raids.modules.Events.EventTable end
-- END_IMPORT

function activateUltimateAbility(hash, playerIndex)
    if ACTIVE_PLAYER_LIST[hash]:getClass().cooldown == false then
        ACTIVE_PLAYER_LIST[hash]:getClass():ultimate(playerIndex)
    else
        local remainingTime = EventTable:getEvent(ACTIVE_PLAYER_LIST[hash]:getClass():getClassName()..playerIndex):getRemainingTime()
        say(playerIndex, "You can use your ultimate ability in " .. math.ceil(remainingTime / 30) .. " seconds!")
    end
end