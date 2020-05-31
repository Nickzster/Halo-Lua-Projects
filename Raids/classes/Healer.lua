-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Class end
-- import Raids.classes.Behaviors.functions end
-- import Raids.util.GetPlayerDistance end
-- END_IMPORT

HEALER_COOLDOWN_IN_SECONDS = 75

HealerSchema=ClassSchema:new():instantiate("healer", HEALER_COOLDOWN_IN_SECONDS * 30)

function HealerSchema.ultimate(self, playerIndex)
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


