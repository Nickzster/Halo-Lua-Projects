-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.util.GetPlayerDistance end
-- END_IMPORT

HEALER_COOLDOWN_IN_SECONDS = 90

HealerSchema = {
    name="healer",
    cooldown=false,
    cooldownTime = HEALER_COOLDOWN_IN_SECONDS * 30,
    weapons={
        primary='lightbringer',
        secondary='faithful',
        third='',
        fourth=''
    }
 }

 HealerSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Healing nearby players!")
    execute_command("hp " .. playerIndex .. " 1.0")
    for i=0,16 do 
        if i ~= playerIndex then
            if player_present(i) and GetPlayerDistance(playerIndex, i) <= 5 then
                execute_command("hp " .. i .. " 1.0")
            end
        end
    end
    self:startCoolDown(playerIndex)
end
HealerSchema['startCoolDown'] = startCoolDown
HealerSchema['coolDownMessage'] = coolDownMessage
HealerSchema['endCoolDown'] = endCoolDown
HealerSchema['getWeapons'] = getWeapons
HealerSchema['new'] = new