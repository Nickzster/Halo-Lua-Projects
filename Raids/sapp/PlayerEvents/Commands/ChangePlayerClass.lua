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
-- import Raids.modules.Balancer.RaidBalancer end
-- import Raids.modules.io.WritePlayerToFile end
-- import Raids.util.ProperClassNames end
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
        if newClass == "tank" and numberOfPlayersWithClass("tank") >= NUMBER_OF_ALLOWED_TANKS then
            say(playerIndex, "Request DENIED. There are too many spartans already!")
        elseif newClass=="healer" and numberOfPlayersWithClass("healer") >= NUMBER_OF_ALLOWED_HEALERS then
            say(playerIndex, "Request DENIED. There are too many medics already!")
        elseif newClass=="bandolier" and numberOfPlayersWithClass("bandolier") >= NUMBER_OF_ALLOWED_BANDOLIERS then
            say(playerIndex, "Request DENIED. There are too many bandoliers already!")
        else
            say(playerIndex, "Request GRANTED. Changing class to " .. displayProperClassName(newClass) .. "!")
            local currentPlayer = ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]
            currentPlayer:setClass(CLASS_LIST[newClass]:new())
            currentPlayer:setPreferredClass(newClass)
            WritePlayerToFile(get_var(playerIndex, "$hash"))
            if player_alive(playerIndex) then kill(playerIndex) end
        end
        return true
    else
        say(playerIndex, "That class does not exist!")
        return false
    end
end
