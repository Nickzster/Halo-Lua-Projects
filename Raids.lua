api_version="1.10.1.0"


TankSchema = {
    weapons= {
    primary='brassknucle',
    secondary='ramart',
    third='',
    fourth=''
    }
}


PlayerSchema = {
    name = "",
    hash = "",
    class=nil
}
HealerSchema = {
    weapons={
        primary='lightbringer',
        secondary='faithful',
        third='',
        fourth=''
    }
 }
DpsSchema = {
    weapons={
    primary='piercer',
    secondary='reliable',
    third='',
    fourth=''
    }
}
--function definitions
new = function(self)
    local newClassInstance = {}
    setmetatable(newClassInstance, self)
    self.__index = self
    return newClassInstance
end

getWeapons = function(self)
    return self.weapons
end

setClass = function(self, class)
    self.class = class
    return self.class
end

getClass = function(self)
    return self.class
end

--function bindings
TankSchema['getWeapons'] = getWeapons
TankSchema['new'] = new

HealerSchema['getWeapons'] = getWeapons
HealerSchema['new'] = new

DpsSchema['getWeapons'] = getWeapons
DpsSchema['new'] = new

PlayerSchema['new'] = new
PlayerSchema['getClass'] = getClass
PlayerSchema['setClass'] = setClass
--Callbacks
function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    print("# # # Callbacks registered successfully!")
end


function handleCommand(playerIndex, Command, Env, RconPassword ) --number, string, number, string
    say(playerIndex, "Welcome to the server!")
end