EventTable = {
    time=nil,
    cb=nil,
    player=nil
}

function EventTable.execute(self)
    self.cb(self.player)
    return true
end

function EventTable.isTimedOut(self)
    if self.time == 0 then return true end
    self.time = self.time - 1
    return false
end

function EventTable.set(self, time, cb, playerIndex)
    self.time = time
    self.cb = cb
    self.player = playerIndex
end

function EventTable.new(self)
    newEventTableInstance = {}
    setmetatable(newEventTableInstance, EventTable)
    self.__index = self
    return newEventTableInstance
end

return EventTable