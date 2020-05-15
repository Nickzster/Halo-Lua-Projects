-- BEGIN_IMPORT
-- import Raids.globals.values end
-- END_IMPORT

EventItem = {
    time=nil,
    completedCb=nil,
    eachTickCb=nil,
    props=nil
}


function EventItem.isTimedOut(self)
    if self.time == -1 then --conditional event
        if self.eachTickCb == nil and self.eachTickCb(self.props, self.time) then
            self.completedCb(self.props)
            return true 
        end
        return false
    elseif self.time == 0 then -- timed event expires
        self.completedCb(self.props)
        return true
    else --timed event has not expired
        self.time = self.time - 1
        if self.eachTickCb ~= nil then self.eachTickCb(self.props, self.time) end
        return false
    end
end

function EventItem.set(self, props, eachTickCb, completedCb, time)
    self.time = time
    self.props = props
    self.completedCb = completedCb
    self.eachTickCb = eachTickCb 
end

function EventItem.new(self)
    local newEventTableInstance = {}
    setmetatable(newEventTableInstance, self)
    self.__index = self
    return newEventTableInstance
end

-- BEGIN_IGNORE
return EventItem
-- END_IGNORE