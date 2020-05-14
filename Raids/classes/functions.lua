-- BEGIN_IMPORT
-- import Raids.src.modules.Classes.Schemas.Player end
-- import Raids.src.modules.Classes.Schemas.Healer end
-- import Raids.src.modules.Classes.Schemas.DPS end
-- import Raids.src.modules.Classes.Schemas.Tank end
-- END_IMPORT

--function definitions
new = function(self)
    local newClassInstance = {}
    setmetatable(newClassInstance, self)
    self.__index = self
    return newClassInstance
end

getWeapons = function(self)
    return self.weapons
end

setClass = function(self, class)
    self.class = class
    return self.class
end

getClass = function(self)
    return self.class
end

--function bindings
TankSchema['getWeapons'] = getWeapons
TankSchema['new'] = new

HealerSchema['getWeapons'] = getWeapons
HealerSchema['new'] = new

DpsSchema['getWeapons'] = getWeapons
DpsSchema['new'] = new

PlayerSchema['new'] = new
PlayerSchema['getClass'] = getClass
PlayerSchema['setClass'] = setClass