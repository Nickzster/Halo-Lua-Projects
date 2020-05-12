

Table = {
    ['hello'] = function() print("Hello, " .. self.name .."!") end,
}



function Table:new(instance)
    local newInstance = instance or {}
    setmetatable(newInstance, self)
    self.__index = self
    return newInstance
end

function Table:newField(k, v)
    -- setmetatable(self, v)
    self[k] = v
end

goodbyeFunction = function() print ("Goodbye, " .. self.name .. "!" ) end

myTable = Table:new(Table)

myTable:newField('goodbye', goodbyeFunction)
myTable:newField('name', 'Nick')

print(myTable.goodbye)
print(goodbyeFunction)
print(myTable.name)
myTable.goodbye()


-- table.hello()
-- table.goodbye()


