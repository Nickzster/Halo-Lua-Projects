-- BEGIN_IMPORT
-- import Raids.classes.Schemas.Player end
-- import Raids.classes.Schemas.Healer end
-- import Raids.classes.Schemas.Dps end
-- import Raids.classes.Schemas.Tank end
-- import Raids.modules.EventQueue.EventTable end
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

startCoolDown = function(self, playerIndex)
    self.cooldown = true
    key = self.name .. playerIndex
    newEventTable = EventTable:new()
    newEventTable:set(self, self.cooldownTime, self.endCoolDown, playerIndex)
    EVENT_TABLE[key]=newEventTable
end

endCoolDown = function(self, playerIndex)
    self.cooldown = false
    say(playerIndex, "Your cool down has ended!")
end

--function bindings
TankSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You executed your ultimate!")
    self:startCoolDown(playerIndex)
end
TankSchema['startCoolDown'] = startCoolDown
TankSchema['endCoolDown'] = endCoolDown
TankSchema['getWeapons'] = getWeapons
TankSchema['new'] = new


HealerSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You executed your ultimate!")
    execute_command("battery " .. playerIndex .. " 100")
    self:startCoolDown(playerIndex)
end
HealerSchema['startCoolDown'] = startCoolDown
HealerSchema['endCoolDown'] = endCoolDown
HealerSchema['getWeapons'] = getWeapons
HealerSchema['new'] = new

DpsSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You executed your ultimate!")
    self:startCoolDown(playerIndex)
end
DpsSchema['startCoolDown'] = startCoolDown
DpsSchema['endCoolDown'] = endCoolDown
DpsSchema['getWeapons'] = getWeapons
DpsSchema['new'] = new

PlayerSchema['new'] = new
PlayerSchema['getClass'] = getClass
PlayerSchema['setClass'] = setClass