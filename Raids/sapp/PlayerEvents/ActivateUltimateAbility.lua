-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.classes.Dps end
-- import Raids.classes.Healer end
-- import Raids.classes.Tank end
-- import Raids.globals.values end
-- END_IMPORT

function activateUltimateAbility(hash, playerIndex)
    if ACTIVE_PLAYER_LIST[hash]:getClass().cooldown == false then
        ACTIVE_PLAYER_LIST[hash]:getClass():ultimate(playerIndex)
    else
        say(playerIndex, "You can use your ultimate ability in " .. math.ceil(EVENT_TABLE[ACTIVE_PLAYER_LIST[hash]:getClass().cooldownStatus].time / 30) .. " seconds!")
    end
end