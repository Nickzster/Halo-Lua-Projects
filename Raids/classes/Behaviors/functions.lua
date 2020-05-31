-- NO_IMPORTS

--function definitions
new = function(self, o)
    print(o)
    local newClassInstance = o or {}
    setmetatable(newClassInstance, self)
    self.__index = self
    return newClassInstance
end











