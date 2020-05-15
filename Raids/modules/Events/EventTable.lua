-- BEGIN_IMPORT
-- import Raids.globals.values end
-- END_IMPORT

EventTable = {
    time=nil,
    completedCb=nil,
    eachTickCb=nil,
    props=nil
}

function EventTable.isTimedOut(self)
    if self.time == 0 then 
        self.completedCb(self.props)
        return true
    else
        self.time = self.time - 1
        if eachTickCb ~= nil then self.eachTickCb(self.props, self.time) end
        return false
    end
end

function EventTable.set(self, props, eachTickCb, completedCb, time)
    self.time = time
    self.props = props
    self.completedCb = completedCb
    self.eachTickCb = eachTickCb 
end

function EventTable.new(self)
    local newEventTableInstance = {}
    setmetatable(newEventTableInstance, self)
    self.__index = self
    return newEventTableInstance
end

-- BEGIN_IGNORE
return EventTable
-- END_IGNORE