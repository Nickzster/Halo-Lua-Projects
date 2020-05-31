-- BEGIN_IMPORT
-- import Raids.classes.Class end
-- import Raids.classes.Behaviors.functions end
-- import Raids.util.GetPlayerDistance end
-- END_IMPORT


GUNSLINGER_COOLDOWN_IN_SECONDS = 120

GunslingerSchema = ClassSchema:new():instantiate("gunslinger", GUNSLINGER_COOLDOWN_IN_SECONDS * 30)

function GunslingerSchema.ultimate(self, playerIndex)
    say(playerIndex, "Engaging active camoflage!")
    execute_command('camo ' .. playerIndex .. " " .. 30)
    self:startCoolDown(playerIndex)
end