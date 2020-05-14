api_version="1.10.1.0"


TANK_COOLDOWN_IN_SECONDS = 25

TankSchema = {
    name="tank",
    cooldown=false,
    cooldownTime = TANK_COOLDOWN_IN_SECONDS * 30,
    weapons= {
    primary='brassknucle',
    secondary='rampart',
    third='',
    fourth=''
    }
}


HEALER_COOLDOWN_IN_SECONDS = 25

HealerSchema = {
    name="healer",
    cooldown=false,
    cooldownTime = HEALER_COOLDOWN_IN_SECONDS * 30,
    weapons={
        primary='lightbringer',
        secondary='faithful',
        third='',
        fourth=''
    }
 }
DPS_COOLDOWN_IN_SECONDS = 25

DpsSchema = {
    name="dps",
    cooldown=false,
    cooldownTime = DPS_COOLDOWN_IN_SECONDS * 30,
    weapons={
    primary='piercer',
    secondary='reliable',
    third='',
    fourth=''
    }
}
PlayerSchema = {
    name = "",
    hash = "",
    class=nil
}
CLASS_LIST = {
    ["dps"] = DpsSchema,
    ["healer"] = HealerSchema,
    ["tank"] = TankSchema
}

WEAPON_DIR_LIST = {
    ["piercer"]="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
    ["reliable"]="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable"
}

BIPED_TAG_LIST = {}

BIPED_DIR_LIST = { 
    ["dps"]="characters\\cyborg_mp\\dps",
    ["healer"]="characters\\cyborg_mp\\healer",
    ["tank"]="zteam\\objects\\characters\\spartan\\h3\\tank"
}

ACTIVE_PLAYER_LIST = {}

EVENT_TABLE = {}




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

startCoolDown = function(self, playerIndex)
    self.cooldown = true
    key = self.name .. playerIndex
    newEventTable = EventTable:new()
    newEventTable:set(self, self.cooldownTime, self.endCoolDown, playerIndex)
    EVENT_TABLE[key]=newEventTable
end

endCoolDown = function(self, playerIndex)
    self.cooldown = false
    say(playerIndex, "Your cool down has ended!")
end

--function bindings
TankSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You executed your ultimate!")
    self:startCoolDown(playerIndex)
end
TankSchema['startCoolDown'] = startCoolDown
TankSchema['endCoolDown'] = endCoolDown
TankSchema['getWeapons'] = getWeapons
TankSchema['new'] = new


HealerSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You executed your ultimate!")
    execute_command("battery " .. playerIndex .. " 100")
    self:startCoolDown(playerIndex)
end
HealerSchema['startCoolDown'] = startCoolDown
HealerSchema['endCoolDown'] = endCoolDown
HealerSchema['getWeapons'] = getWeapons
HealerSchema['new'] = new

DpsSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You executed your ultimate!")
    self:startCoolDown(playerIndex)
end
DpsSchema['startCoolDown'] = startCoolDown
DpsSchema['endCoolDown'] = endCoolDown
DpsSchema['getWeapons'] = getWeapons
DpsSchema['new'] = new

PlayerSchema['new'] = new
PlayerSchema['getClass'] = getClass
PlayerSchema['setClass'] = setClass
function FindBipedTag(TagName)
    local tag_array = read_dword(0x40440000)
    for i=0,read_word(0x4044000C)-1 do
        local tag = tag_array + i * 0x20
        if(read_dword(tag) == 1651077220 and read_string(read_dword(tag + 0x10)) == TagName) then
            return read_dword(tag + 0xC)
        end
    end
end
function loadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new()
    newPlayer:setClass(CLASS_LIST["dps"]:new())
    ACTIVE_PLAYER_LIST[hash] = newPlayer
end

function changePlayerClass(playerIndex, newClass)
    kill(playerIndex)
    ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]:setClass(CLASS_LIST[newClass]:new())
end



function unloadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    ACTIVE_PLAYER_LIST[hash] = nil
end


function parseCommand(playerIndex, command)
    args = {} 
    local hash = get_var(playerIndex, "$hash")
    for w in command:gmatch("%w+") do args[#args+1] = w end
        if args[1] == "class" then 
            if CLASS_LIST[args[2]] ~= nil then
                changePlayerClass(playerIndex, args[2])
            else
                say(playerIndex, "That class does not exist!")
            end
            return true
        elseif args[1] == "ultimate" then
            if ACTIVE_PLAYER_LIST[hash]:getClass().cooldown == false then
                ACTIVE_PLAYER_LIST[hash]:getClass():ultimate(playerIndex)
            else
                say(playerIndex, "This ability is on cooldown!")
            end
            return true
        elseif args[1] == "whoami" then
            say(playerIndex, "You are a " .. ACTIVE_PLAYER_LIST[hash]:getClass().name)
            return true
        end
        return false
end
function loadBipeds()
    --Load in Biped Table
    for key,_ in pairs(BIPED_DIR_LIST) do
        BIPED_TAG_LIST[key] = FindBipedTag(BIPED_DIR_LIST[key])
    end
    --Load in default biped
    local tag_array = read_dword(0x40440000)
    for i=0,read_word(0x4044000C)-1 do
        local tag = tag_array + i * 0x20
        if(read_dword(tag) == 1835103335 and read_string(read_dword(tag + 0x10)) == "globals\\globals") then
            local tag_data = read_dword(tag + 0x14)
            local mp_info = read_dword(tag_data + 0x164 + 4)
            for j=0,read_dword(tag_data + 0x164)-1 do
                BIPED_TAG_LIST['DEFAULT'] = read_dword(mp_info + j * 160 + 0x10 + 0xC)
            end
        end
    end
end



--Callbacks
function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    register_callback(cb['EVENT_JOIN'], "handleJoin")
    register_callback(cb['EVENT_LEAVE'], "handleLeave")
    register_callback(cb['EVENT_DAMAGE_APPLICATION'], "handleDamage")
    register_callback(cb['EVENT_OBJECT_SPAWN'], "handleSpawn")
    register_callback(cb['EVENT_TICK'], "handleTick")
end


function OnScriptUnload()

end

function handleDamage(playerIndex, damagerPlayerIndex, damageTagId, Damage, CollisionMaterial, Backtap) end

function handleTick()
    for key,_ in pairs(EVENT_TABLE) do
        if EVENT_TABLE[key]:isTimedOut() == true then
            EVENT_TABLE[key]:execute()
            EVENT_TABLE[key] = nil 
        end
    end

end

function handleSpawn(playerIndex, tagId, parentObjectId, newObjectId)
    if BIPED_TAG_LIST['DEFAULT'] == nil then 
        loadBipeds() 
    end
    if player_present(playerIndex) and tagId == BIPED_TAG_LIST['DEFAULT'] then 
        local hash = get_var(playerIndex, "$hash")
        return true,BIPED_TAG_LIST[ACTIVE_PLAYER_LIST[hash]:getClass().name]
    end
end

function handleJoin(playerIndex) 
    if player_present(playerIndex) then
        loadPlayer(playerIndex)
    end
end


function handleLeave(playerIndex) 
    if player_present(playerIndex) then
        unloadPlayer(playerIndex)
    end
end


function handleCommand(playerIndex, Command, Env, RconPassword ) --number, string, number, string
    if player_present(playerIndex) then
        if parseCommand(playerIndex, Command) == true then return false end
    end
end