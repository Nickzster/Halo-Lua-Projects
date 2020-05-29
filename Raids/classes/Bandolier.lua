-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.globals.values end
-- import Raids.classes.Behaviors.functions end
-- import Raids.util.GetPlayerDistance end
-- END_IMPORT

BANDOLIER_COOLDOWN_IN_SECONDS = 75

BandolierSchema = {
    name="bandolier",
    cooldown=false,
    cooldownTime = BANDOLIER_COOLDOWN_IN_SECONDS * 30,
    maxHealth = 100,
}

BandolierSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Giving all nearby players ammo!")
    for i=0, 16 do
        if player_present(i) 
        and ACTIVE_BOSSES[i] == nil 
        and GetPlayerDistance(playerIndex, i) <= 5
        or i == playerIndex then
            local currentPlayer = ACTIVE_PLAYER_LIST[get_var(i, "$hash")]
            execute_command("ammo " .. i .. " " .. currentPlayer:getPrimaryWeapon():getModifier() .. " 3")
            execute_command("ammo " .. i .." " .. currentPlayer:getSecondaryWeapon():getModifier() .. " 4")
            execute_command("battery " .. i .. " 100 5")
        end
    end
    self:startCoolDown(playerIndex)
end

BandolierSchema['getClassName'] = getClassName
BandolierSchema['startCoolDown'] = startCoolDown
BandolierSchema['coolDownMessage'] = coolDownMessage
BandolierSchema['endCoolDown'] = endCoolDown
BandolierSchema['new'] = new