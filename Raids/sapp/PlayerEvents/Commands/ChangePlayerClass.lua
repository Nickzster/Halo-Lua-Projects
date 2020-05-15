-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.classes.Dps end
-- import Raids.classes.Healer end
-- import Raids.classes.Tank end
-- import Raids.classes.Boss end
-- import Raids.globals.values end
-- END_IMPORT

CLASS_LIST = {
    ["dps"] = DpsSchema,
    ["healer"] = HealerSchema,
    ["tank"] = TankSchema,
    ["boss"] = BossSchema
}

function changePlayerClass(playerIndex, newClass)
    if CLASS_LIST[newClass] ~= nil or newClass == "boss" then
        kill(playerIndex)
        ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]:setClass(CLASS_LIST[newClass]:new())
        return true
    else
        say(playerIndex, "That class does not exist!")
        return false
    end
end
