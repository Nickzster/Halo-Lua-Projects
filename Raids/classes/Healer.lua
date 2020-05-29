-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Behaviors.functions end
-- import Raids.util.GetPlayerDistance end
-- END_IMPORT

HEALER_COOLDOWN_IN_SECONDS = 75

HealerSchema = {
    name="healer",
    cooldown=false,
    cooldownTime = HEALER_COOLDOWN_IN_SECONDS * 30,
    maxHealth=100,
 }

 HealerSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Healing nearby players!")
    for i=0,16 do 
        if player_present(i) 
        and ACTIVE_BOSSES[i] == nil
        and GetPlayerDistance(playerIndex, i) <= 5 
        or i == playerIndex then
            execute_command("hp " .. i .. " 1.0")
        end
    end
    self:startCoolDown(playerIndex)
end


HealerSchema['getClassName'] = getClassName
HealerSchema['startCoolDown'] = startCoolDown
HealerSchema['coolDownMessage'] = coolDownMessage
HealerSchema['endCoolDown'] = endCoolDown
HealerSchema['new'] = new