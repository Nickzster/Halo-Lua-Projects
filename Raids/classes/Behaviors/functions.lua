-- BEGIN_IMPORT
-- import Raids.modules.Events.EventItem end
-- import Raids.modules.Events.EventTable end
-- import Raids.globals.RaidItems end
-- import Raids.classes.Behaviors.ClassBehaviors end
-- END_IMPORT

--function definitions
new = function(self)
    local newClassInstance = {}
    setmetatable(newClassInstance, self)
    self.__index = self
    return newClassInstance
end











