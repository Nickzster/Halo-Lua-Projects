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

--for testing
return Queue

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

api_version = "1.10.1.0"
--Callbacks

function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    print("# # # Callbacks registered successfully!")
end


function handleCommand(playerIndex, Command, Env, RconPassword ) --number, string, number, string
    say(playerIndex, "Welcome to the server!")
end

