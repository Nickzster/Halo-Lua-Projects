Player = {
    name = "",
    hash = "",
    health = 100,
    weapons = {
        primary = "Assault Rifle",
        secondary = "Pistol"
    }
}

function Player.new(self) --or Player:new() to hide the "self" argument
    newInstance = {}
    setmetatable(newInstance, self)
    self.__index = self;
    return newInstance;
end

DpsClass = Player:new()
TankClass = Player:new()
HealerClass = Player:new()

DpsClass['weapons'] = {
    primary = "Battle Rifle",
    secondary = "Pistol"
}
HealerClass['weapons'] = {
    primary = "PlasmaPistol",
    secondary = nil
}
TankClass['weapons'] = {
    primary = "Rocket Launcher",
    secondary = "Sniper Rifle"
}


function DpsClass:takeDamage()
    self.health = self.health - 10
    return self.health
end

function TankClass:takeDamage()
    self.health = self.health - 5
    return self.health
end

function HealerClass:takeDamage()
    self.health = self.health - 15
    return self.health
end

p1 = DpsClass:new()
p2 = TankClass:new()
p3 = HealerClass:new()

p3:takeDamage()
p2:takeDamage()
p1:takeDamage()

print(p1.health)
print(p2.health)
print(p3.health)

print(p1.weapons.primary)

