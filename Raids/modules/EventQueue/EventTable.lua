-- NO_IMPORTS

EventTable = {
    time=nil,
    cb=nil,
    player=nil,
    object=nil
}

function EventTable.execute(self)
    self.cb(self.object, self.player)
    return true
end

function EventTable.isTimedOut(self)
    if self.time == 0 then return true end
    self.time = self.time - 1
    return false
end

function EventTable.set(self, object, time, cb, playerIndex)
    self.object = object
    self.time = time
    self.cb = cb
    self.player = playerIndex
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