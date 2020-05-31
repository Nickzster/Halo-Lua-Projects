-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.classes.Class end
-- import Raids.globals.values end
-- import Raids.modules.Events.EventItem end
-- END_IMPORT


BossSchema=ClassSchema:new():instantiate("boss", 0)

function BossSchema.new(self)
    local newInstance = ClassSchema:new():instantiate("boss", 0, 0)
    return new(self, newInstance)
end