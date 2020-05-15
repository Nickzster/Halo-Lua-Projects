api_version="1.10.1.0"


WEAPON_DIR_LIST = {
    ["piercer"]="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
    ["reliable"]="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable"
}

BIPED_TAG_LIST = {}

BIPED_DIR_LIST = { 
    ["dps"]="characters\\cyborg_mp\\dps",
    ["healer"]="characters\\cyborg_mp\\healer",
    ["tank"]="zteam\\objects\\characters\\spartan\\h3\\tank",
    ["scourge"]="h2spp\\characters\\flood\\juggernaut\\scourge",
    ["torres"]="rangetest\\cmt\\characters\\evolved_h1-spirit\\cyborg\\bipeds\\torres",
    ["eliminator"]="rangetest\\cmt\\characters\\spv3\\forerunner\\enforcer\\bipeds\\eliminator",
    ["kreyul"]="shdwslyr\\reach_elite\\ultra\\kreyul",
}

ACTIVE_PLAYER_LIST = {}

EVENT_TABLE = {}




EventTable = {
    time=nil,
    completedCb=nil,
    eachTickCb=nil,
    props=nil
}

function EventTable.isTimedOut(self)
    if self.time == 0 then 
        self.completedCb(self.props)
        return true
    else
        self.time = self.time - 1
        if eachTickCb ~= nil then self.eachTickCb(self.props, self.time) end
        return false
    end
end

function EventTable.set(self, props, eachTickCb, completedCb, time)
    self.time = time
    self.props = props
    self.completedCb = completedCb
    self.eachTickCb = eachTickCb 
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
    self.cooldownStatus = key
    newEventTable = EventTable:new()
    newEventTable:set({
        ['self']=self,
        ['playerIndex']=playerIndex
    }, self.coolDownMessage, self.endCoolDown, self.cooldownTime)
    EVENT_TABLE[key]=newEventTable
end

coolDownMessage = function(props, time)
    local playerIndex = props.playerIndex
    if playerIndex ~= nil then
        if time == 10 * 30 then
            say(playerIndex, "Ultimate ability will be ready in 10 seconds!")
        end
    end
end

endCoolDown = function(props)
    local obj = props.self
    local playerIndex = props.playerIndex
    obj.cooldown = false
    obj.cooldownStatus = nil
    if playerIndex ~= nil then
        say(playerIndex, "Ultimate ability is ready to use again!")
    end
end










PlayerSchema = {
    name = "",
    hash = "",
    class=nil
}

PlayerSchema['new'] = new
PlayerSchema['getClass'] = getClass
PlayerSchema['setClass'] = setClass
DPS_COOLDOWN_IN_SECONDS = 130

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

DpsSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You now have bottomless clip for your current weapon!")
    execute_command("mag " .. playerIndex .. " 999")
    self:startCoolDown(playerIndex)
    local key = "PLAYER_" .. playerIndex .. "_IS_EXECUTING_DPS_ULTIMATE"
    local newEvent = EventTable:new()
    newEvent:set({
        ['playerIndex']=playerIndex
    }, nil, function(props) say(props.playerIndex, "Your weapon is now back to normal.") execute_command("mag " .. props.playerIndex .. " 0") end, 10 * 30)
    EVENT_TABLE[key] = newEvent
end
DpsSchema['startCoolDown'] = startCoolDown
DpsSchema['coolDownMessage'] = coolDownMessage
DpsSchema['endCoolDown'] = endCoolDown
DpsSchema['getWeapons'] = getWeapons
DpsSchema['new'] = new
HEALER_COOLDOWN_IN_SECONDS = 90

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

 HealerSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Healing nearby players!")
    execute_command("hp " .. playerIndex .. " 1.0")
    for i=0,16 do 
        if i ~= playerIndex then
            if player_present(i) and GetPlayerDistance(playerIndex, i) <= 5 then
                execute_command("hp " .. i .. " 1.0")
            end
        end
    end
    self:startCoolDown(playerIndex)
end
HealerSchema['startCoolDown'] = startCoolDown
HealerSchema['coolDownMessage'] = coolDownMessage
HealerSchema['endCoolDown'] = endCoolDown
HealerSchema['getWeapons'] = getWeapons
HealerSchema['new'] = new
BossSchema = {
    name="DEFAULT",
    boss=true
}

BossSchema['new'] = new
BossSchema['changeBoss'] = function(self, newBiped)
    self.name = newBiped
end
function FindBipedTag(TagName)
    local tag_array = read_dword(0x40440000)
    for i=0,read_word(0x4044000C)-1 do
        local tag = tag_array + i * 0x20
        if(read_dword(tag) == 1651077220 and read_string(read_dword(tag + 0x10)) == TagName) then
            return read_dword(tag + 0xC)
        end
    end
end
function GetPlayerDistance(index1, index2)
	local p1 = get_dynamic_player(index1)
	local p2 = get_dynamic_player(index2)
	
	return math.sqrt((read_float(p2+0x5C  ) - read_float(p1+0x5C  ))^2
	                +(read_float(p2+0x5C+4) - read_float(p1+0x5C+4))^2
	                +(read_float(p2+0x5C+8) - read_float(p1+0x5C+8))^2)
end
TANK_COOLDOWN_IN_SECONDS = 127

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

TankSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You are now temporarly invincible!")
    execute_command("god " .. playerIndex)
    local key = "PLAYER_" .. playerIndex .. "_IS_EXECUTING_TANK_ULTIMATE"
    self:startCoolDown(playerIndex)
    local ungodEvent = EventTable:new()
    ungodEvent:set({
        ['playerIndex']=playerIndex
    }, nil, function(props) execute_command("ungod " .. props.playerIndex) say(props.playerIndex, "You are no longer invincible!") end, 7 * 30)
    EVENT_TABLE[key] = ungodEvent
end
TankSchema['startCoolDown'] = startCoolDown
TankSchema['coolDownMessage'] = coolDownMessage
TankSchema['endCoolDown'] = endCoolDown
TankSchema['getWeapons'] = getWeapons
TankSchema['new'] = new


function activateUltimateAbility(hash, playerIndex)
    if ACTIVE_PLAYER_LIST[hash]:getClass().cooldown == false then
        ACTIVE_PLAYER_LIST[hash]:getClass():ultimate(playerIndex)
    else
        say(playerIndex, "You can use your ultimate ability in " .. math.ceil(EVENT_TABLE[ACTIVE_PLAYER_LIST[hash]:getClass().cooldownStatus].time / 30) .. " seconds!")
    end
end
function parseCommand(playerIndex, command)
    args = {} 
    local hash = get_var(playerIndex, "$hash")
    for w in command:gmatch("%w+") do args[#args+1] = w end
        if args[1] == "class" then 
            if args[2] == "boss" and tonumber(get_var(playerIndex, "$lvl")) ~= 4 then
                say(playerIndex, "You must be an admin to become a boss!")
            else
                changePlayerClass(playerIndex, args[2])
            end
            return true
        elseif args[1] == "ult" or args[1] == "ultimate" then
            if ACTIVE_PLAYER_LIST[hash]:getClass().boss == nil then
                activateUltimateAbility(hash, playerIndex)
            else
                say(playerIndex, "Bosses cannot do that!")
            end
            return true
        elseif args[1] == "sp" then
            spawn_object("weap", "halo reach\\objects\\weapons\\support_high\\spartan_laser\\savant", 105.62, 342.36, -3)
            return true
        elseif args[1] == "boss" then
            if tonumber(get_var(playerIndex, "$lvl")) == 4 and ACTIVE_PLAYER_LIST[hash]:getClass().boss ~= nil then
                if BIPED_TAG_LIST[args[2]] ~= nil then
                    kill(playerIndex)
                    local playerClass = ACTIVE_PLAYER_LIST[hash]:getClass()
                    playerClass:changeBoss(args[2])
                else
                    say(playerIndex, "That boss does not exist!")
                end
                return true
            else
                say(playerIndex, "You cannot do that!")
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
function loadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new()
    newPlayer:setClass(DpsSchema:new())
    ACTIVE_PLAYER_LIST[hash] = newPlayer
end
function unloadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    ACTIVE_PLAYER_LIST[hash] = nil
end

CLASS_LIST = {
    ["dps"] = DpsSchema,
    ["healer"] = HealerSchema,
    ["tank"] = TankSchema,
    ["boss"] = BossSchema
}

function changePlayerClass(playerIndex, newClass)
    if CLASS_LIST[newClass] ~= nil or newClass == "boss" then
        kill(playerIndex)
        ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]:setClass(CLASS_LIST[newClass]:new())
        return true
    else
        say(playerIndex, "That class does not exist!")
        return false
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

function handleDamage(playerIndex, damagerPlayerIndex, damageTagId, Damage, CollisionMaterial, Backtap) 
    if player_present(playerIndex) then
        say(playerIndex, "You are taking " .. Damage .. " from player with index " .. damagerPlayerIndex)
        say(damagerPlayerIndex, "You are dealing " .. Damage .. " to player with index " .. playerIndex)
    end
end

function handleTick()
    for key,_ in pairs(EVENT_TABLE) do
        if EVENT_TABLE[key]:isTimedOut() == true then
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