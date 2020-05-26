-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.util.GetPlayerDistance end
-- END_IMPORT


GUNSLINGER_COOLDOWN_IN_SECONDS = 120

GunslingerSchema = {
    name="gunslinger",
    cooldown = false,
    cooldownTime = GUNSLINGER_COOLDOWN_IN_SECONDS * 30,
    maxHealth = 100,
}


GunslingerSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Engaging active camoflage!")
    execute_command('camo ' .. playerIndex .. " " .. 30)
    self:startCoolDown(playerIndex)
end

GunslingerSchema['startCoolDown'] = startCoolDown
GunslingerSchema['cooldownMessage'] = cooldownMessage
GunslingerSchema['endCoolDown'] = endCoolDown
GunslingerSchema['getWeapons'] = getWeapons
GunslingerSchema['new'] = new