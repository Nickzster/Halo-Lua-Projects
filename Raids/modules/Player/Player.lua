Player = {
    name = "",
    hash = "",
    weapons = {
        primary: "ar",
        secondary: "pistol"
    }
}

function Player:new(instance)
    newInstance = instance or {}
    print(self)
    setmetatable(newInstance, self)
    self.__index = self
    return newInstance
end