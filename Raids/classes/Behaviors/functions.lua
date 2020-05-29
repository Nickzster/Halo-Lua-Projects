-- BEGIN_IMPORT
-- import Raids.modules.Events.EventItem end
-- import Raids.modules.Events.EventTable end
-- import Raids.globals.RaidItems end
-- END_IMPORT

--function definitions
new = function(self)
    local newClassInstance = {}
    setmetatable(newClassInstance, self)
    self.__index = self
    return newClassInstance
end

setClass = function(self, class)
    self.class = class
    return self.class
end

getClass = function(self)
    return self.class
end

getClassName = function(self)
    return self.name
end


startCoolDown = function(self, playerIndex)
    self.cooldown = true
    key = self.name .. playerIndex
    self.cooldownStatus = key
    newEventItem = EventItem:new()
    newEventItem:set({
        ['self']=self,
        ['playerIndex']=playerIndex
    }, self.coolDownMessage, self.endCoolDown, self.cooldownTime)
    EventTable:addEvent(key, newEventItem)
end

coolDownMessage = function(props, time)
    local playerIndex = props.playerIndex
    if playerIndex ~= nil then
        if time == 10 * 30 then
            say(playerIndex, "Ultimate ability will be ready in 10 seconds!")
        end
    end
end

endCoolDown = function(props)
    local obj = props.self
    local playerIndex = props.playerIndex
    obj.cooldown = false
    obj.cooldownStatus = nil
    if playerIndex ~= nil then
        say(playerIndex, "Ultimate ability is ready to use again!")
    end
end









