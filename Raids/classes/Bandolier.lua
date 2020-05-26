-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Behaviors.functions end
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
    self:startCoolDown(playerIndex)
end

BandolierSchema['startCoolDown'] = startCoolDown
BandolierSchema['coolDownMessage'] = coolDownMessage
BandolierSchema['endCoolDown'] = endCoolDown
BandolierSchema['getWeapons'] = getWeapons
BandolierSchema['new'] = new