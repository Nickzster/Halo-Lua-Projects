-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.classes.Dps end
-- import Raids.classes.Healer end
-- import Raids.classes.Tank end
-- import Raids.classes.Boss end
-- import Raids.classes.Gunslinger end
-- import Raids.classes.Bandolier end
-- import Raids.globals.RaidItems end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.globals.values end
-- import Raids.modules.io.WritePlayerToFile end
-- END_IMPORT

CLASS_LIST = {
    ["dps"] = DpsSchema,
    ["healer"] = HealerSchema,
    ["tank"] = TankSchema,
    ["boss"] = BossSchema,
    ["gunslinger"] = GunslingerSchema,
    ["bandolier"] = BandolierSchema
}

function changePlayerClass(playerIndex, newClass)
    if CLASS_LIST[newClass] ~= nil then
        local currentPlayer = ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]
        currentPlayer:setClass(CLASS_LIST[newClass]:new())
        currentPlayer:setPreferredClass(newClass)
        WritePlayerToFile(get_var(playerIndex, "$hash"))
        if player_alive(playerIndex) then kill(playerIndex) end
        return true
    else
        say(playerIndex, "That class does not exist!")
        return false
    end
end
