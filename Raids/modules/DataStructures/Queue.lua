-- NO_IMPORTS

Queue = {}

function Queue:new()
    instance = {first=0, last = -1}
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function Queue:push(val)
    self.last = self.last + 1
    self[self.last] = val
end

function Queue:peek()
    return self[self.first]
end

function Queue:pop()
    if self.last == -1 then return end
    local val = self[self.first]
    self[self.first] = nil
    self.first = self.first + 1
    if self.first > self.last then self.first = 0 self.last = -1 end
    return val
end

-- BEGIN_IGNORE
return Queue
-- END_IGNORE