DpsSchema = {
    weapons={
    primary='piercer',
    secondary='reliable',
    third='',
    fourth=''
    }
}

TankSchema = {
    weapons= {
    primary='brassknucle',
    secondary='ramart',
    third='',
    fourth=''
    }
}

HealerSchema = {
    weapons={
        primary='lightbringer',
        secondary='faithful',
        third='',
        fourth=''
    }
 }

PlayerSchema = {
    name = "",
    hash = "",
    class=nil
}




function instantiate()
    local newDPS = DpsSchema:new()
    local newHealer = HealerSchema:new()
    p1 = PlayerSchema:new()
    p2 = PlayerSchema:new()
    p1:setClass(newDPS)
    p2:setClass(newHealer)
end

instantiate()

p1class = p1:getClass()
p2class = p2:getClass()

print(p1class:getWeapons().primary)
print(p2class:getWeapons().primary)


