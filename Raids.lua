api_version="1.10.1.0"


WEAPON_DIR_LIST = {
    ["piercer"]="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
    ["reliable"]="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable"
}

BIPED_DIR_LIST = { 
    ["dps"]="characters\\cyborg_mp\\dps",
    ["healer"]="characters\\cyborg_mp\\healer",
    ["tank"]="zteam\\objects\\characters\\spartan\\h3\\tank",
    ["bandolier"]="bourrin\\halo reach\\marine-to-spartan\\bandolier",
    ["gunslinger"]="h3\\objects\\characters\\elite\\gunslinger",
    ["scourge"]="h2spp\\characters\\flood\\juggernaut\\scourge",
    ["torres"]="rangetest\\cmt\\characters\\evolved_h1-spirit\\cyborg\\bipeds\\torres",
    ["eliminator"]="rangetest\\cmt\\characters\\spv3\\forerunner\\enforcer\\bipeds\\eliminator",
    ["kreyul"]="shdwslyr\\reach_elite\\ultra\\kreyul",
}

ITEM_LIST = {
    ["armor_piercing"] = {
        ["description"]="Doubles your damage output.",
        ["type"]="OUTPUT_DAMAGE_MODIFIER",
        ["modifier"]=2.0
    },
    ["shield"]={
        ["description"]="Reduces incoming damage by half.",
        ["type"]="INPUT_DAMAGE_MODIFIER",
        ["modifier"]=0.5
    },
    ["healingorb"]={
        ["description"]="2 Health regenerated per second.",
        ["type"]="HEALING_MODIFIER",
        ["modifier"]=2
    }
}

LOCATIONS= {
    ["torres_event_1"] = "an important computer!"
}

BIPED_TAG_LIST = {}

ACTIVE_PLAYER_LIST = {}

ACTIVE_BOSSES = {}

EVENT_TABLE = {}




EventItem = {
    time=nil,
    completedCb=nil,
    eachTickCb=nil,
    props=nil
}


function EventItem.isTimedOut(self)
    if self.time == -1 then --conditional event
        if self.eachTickCb ~= nil and self.eachTickCb(self.props, self.time) then
            self.completedCb(self.props)
            return true 
        end
        return false
    elseif self.time == 0 then -- timed event expires
        self.completedCb(self.props)
        return true
    else --timed event has not expired
        self.time = self.time - 1
        if self.eachTickCb ~= nil then self.eachTickCb(self.props, self.time) end
        return false
    end
end

function EventItem.set(self, props, eachTickCb, completedCb, time)
    self.time = time
    self.props = props
    self.completedCb = completedCb
    self.eachTickCb = eachTickCb 
end

function EventItem.new(self)
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
    newEventItem = EventItem:new()
    newEventItem:set({
        ['self']=self,
        ['playerIndex']=playerIndex
    }, self.coolDownMessage, self.endCoolDown, self.cooldownTime)
    EVENT_TABLE[key]=newEventItem
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










ItemSchema = {
    ['name']=nil,
    ['description']=nil,
    ['type']=nil,
    ['modifier']=nil,
    ['key']=nil
}

ItemSchema['new'] = new

function ItemSchema:destroyItem()

end

function ItemSchema:createItem(name, description, type, modifier, playerIndex) 
    self.name = name
    self.description = description
    self.type = type
    if self.type == "HEALING_MODIFIER" then
        local key = 'HEALING_MODIFIER_FOR_PLAYER_' ..playerIndex
        local newHealthRegenModifier = EventItem:new()
        newHealthRegenModifier:set({
            ['playerIndex'] = playerIndex
        }, function (props, time)
            --TODO: Implement health writing here
        end, function(props)
            --TODO: Implement a complete method here
        end, -1)
        EVENT_TABLE[key] = newHealthRegenModifier
        self.key = key
    end
    self.modifier = modifier
end


PlayerSchema = {
    playerIndex=nil,
    inventory={},
    unlocks={},
    locations={},
    class=nil
}

function PlayerSchema:isInLocation(location)
    if self.locations[location] ~= nil then return true else return false end
end

function PlayerSchema:setLocation(newLocation)
    self.locations[newLocation] = newLocation
end

function PlayerSchema:removeLocation(location)
    self.locations[location] = nil
end

function PlayerSchema:addInventoryItem(itemName)
    if ITEM_LIST[itemName] then
        newItem = ItemSchema:new()
        newItem:createItem(itemName, ITEM_LIST[itemName].description, ITEM_LIST[itemName].modifier, self.playerIndex)
        self.inventory[itemName] = newItem
    end
end

function PlayerSchema:getPlayerInventory()
    return self.inventory
end

function PlayerSchema:removeInventoryItem(itemName)
    self.inventory[itemName] = nil
end

function PlayerSchema:addUnlock(weaponName)
    if WEAPON_DIR_LIST[weaponName] then
        self.unlocks[weaponName] = weaponName
    end
end

function PlayerSchema:setPlayerIndex(playerIndex)
    self.playerIndex = playerIndex
end

--TODO: Future, disallow duplicate redeemUnlocks
function PlayerSchema:redeemUnlock(weaponName)
    if self.unlocks[weaponName] then
        local weaponToGive = spawn_object("weapon", WEAPON_DIR_LIST[weaponName])
        assign_weapon(weaponToGive, tonumber(playerIndex))
    end
end

PlayerSchema['new'] = new
PlayerSchema['getClass'] = getClass
PlayerSchema['setClass'] = setClass
BossHealthValues = {
    ["DEFAULT"] = 1000,
    ["scourge"] = 5000,
    ["torres"] = 1500,
    ["eliminator"] = 2000,
    ["kreyul"] = 1000
}

BossSchema = {
    name="DEFAULT",
    boss=true,
    maxHealth=100
}

BossSchema['new'] = new
BossSchema['changeBoss'] = function(self, newBiped)
    self.name = newBiped
    self.maxHealth = BossHealthValues[newBiped]
end
function GetPlayerDistance(index1, index2)
	local p1 = get_dynamic_player(index1)
	local p2 = get_dynamic_player(index2)
	
	return math.sqrt((read_float(p2+0x5C  ) - read_float(p1+0x5C  ))^2
	                +(read_float(p2+0x5C+4) - read_float(p1+0x5C+4))^2
	                +(read_float(p2+0x5C+8) - read_float(p1+0x5C+8))^2)
end
DPS_COOLDOWN_IN_SECONDS = 70

DpsSchema = {
    name="dps",
    cooldown=false,
    cooldownTime = DPS_COOLDOWN_IN_SECONDS * 30,
    maxHealth=100,
    weapons={
    primary='piercer',
    secondary='reliable',
    third='',
    fourth=''
    }
}

DpsSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "All of your weapons now have bottomless clip!")
    execute_command("mag " .. playerIndex .. " 999 5")
    self:startCoolDown(playerIndex)
    local key = "PLAYER_" .. playerIndex .. "_IS_EXECUTING_DPS_ULTIMATE"
    local newEvent = EventItem:new()
    newEvent:set({
        ['playerIndex']=playerIndex
    }, nil, function(props) say(props.playerIndex, "Your weapons are now back to normal.") execute_command("mag " .. props.playerIndex .. " 0 5") end, 10 * 30)
    EVENT_TABLE[key] = newEvent
end
DpsSchema['startCoolDown'] = startCoolDown
DpsSchema['coolDownMessage'] = coolDownMessage
DpsSchema['endCoolDown'] = endCoolDown
DpsSchema['getWeapons'] = getWeapons
DpsSchema['new'] = new

GUNSLINGER_COOLDOWN_IN_SECONDS = 120

GunslingerSchema = {
    name="gunslinger",
    cooldown = false,
    cooldownTime = GUNSLINGER_COOLDOWN_IN_SECONDS * 30,
    maxHealth = 100,
    weapons = {}
}


GunslingerSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Engaging active camoflage!")
    execute_command('camo ' .. playerIndex .. " " .. 30)
    self:startCoolDown(playerIndex)
end

GunslingerSchema['startCoolDown'] = startCoolDown
GunslingerSchema['cooldownMessage'] = cooldownMessage
GunslingerSchema['endCoolDown'] = endCoolDown
GunslingerSchema['getWeapons'] = getWeapons
GunslingerSchema['new'] = new
BANDOLIER_COOLDOWN_IN_SECONDS = 75

BandolierSchema = {
    name="bandolier",
    cooldown=false,
    cooldownTime = BANDOLIER_COOLDOWN_IN_SECONDS * 30,
    maxHealth = 100,
    weapons = {},
}

BandolierSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Giving all nearby players ammo!")
    self:startCoolDown(playerIndex)
end

BandolierSchema['startCoolDown'] = startCoolDown
BandolierSchema['coolDownMessage'] = coolDownMessage
BandolierSchema['endCoolDown'] = endCoolDown
BandolierSchema['getWeapons'] = getWeapons
BandolierSchema['new'] = new
TANK_COOLDOWN_IN_SECONDS = 100

TankSchema = {
    name="tank",
    cooldown=false,
    cooldownTime = TANK_COOLDOWN_IN_SECONDS * 30,
    maxHealth=500,
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
    local ungodEvent = EventItem:new()
    ungodEvent:set({
        ['playerIndex']=playerIndex
    }, nil, function(props) execute_command("ungod " .. props.playerIndex) say(props.playerIndex, "You are no longer invincible!") end, 10 * 30)
    EVENT_TABLE[key] = ungodEvent
end
TankSchema['startCoolDown'] = startCoolDown
TankSchema['coolDownMessage'] = coolDownMessage
TankSchema['endCoolDown'] = endCoolDown
TankSchema['getWeapons'] = getWeapons
TankSchema['new'] = new


HEALER_COOLDOWN_IN_SECONDS = 75

HealerSchema = {
    name="healer",
    cooldown=false,
    cooldownTime = HEALER_COOLDOWN_IN_SECONDS * 30,
    maxHealth=100,
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
function FindBipedTag(TagName)
    local tag_array = read_dword(0x40440000)
    for i=0,read_word(0x4044000C)-1 do
        local tag = tag_array + i * 0x20
        if(read_dword(tag) == 1651077220 and read_string(read_dword(tag + 0x10)) == TagName) then
            return read_dword(tag + 0xC)
        end
    end
end
function parseCommand(playerIndex, command)
    args = {} 
    local hash = get_var(playerIndex, "$hash")
    local player = ACTIVE_PLAYER_LIST[hash]
    for w in command:gmatch("%w+") do args[#args+1] = w end
        if args[1] == "class" then 
            if args[2] == "boss" and tonumber(get_var(playerIndex, "$lvl")) ~= 4 then
                say(playerIndex, "You must be an admin to become a boss!")
            else
                changePlayerClass(playerIndex, args[2])
            end
            return true
        elseif args[1] == "ult" or args[1] == "ultimate" then
            if player:getClass().boss == nil then
                activateUltimateAbility(hash, playerIndex)
            else
                say(playerIndex, "Bosses cannot do that!")
            end
            return true
        elseif args[1] == "sp" then
            say_all("Spawning sound!")
            spawn_object("weap", "weapons\\raidsmusic\\overwatchtorresintro", 102.23, 417.59, 5)
            return true
        elseif args[1] == "test" then
            player:addInventoryItem("armor_piercing")
            return true
        elseif args[1] == "boss" then
            if tonumber(get_var(playerIndex, "$lvl")) == 4 and player:getClass().boss ~= nil then
                changeBoss(playerIndex, player, args[2])
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
CLASS_LIST = {
    ["dps"] = DpsSchema,
    ["healer"] = HealerSchema,
    ["tank"] = TankSchema,
    ["boss"] = BossSchema,
    ["gunslinger"] = GunslingerSchema,
    ["bandolier"] = BandolierSchema
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

function changeBoss(playerIndex, player, selectedBoss)
    if BIPED_TAG_LIST[selectedBoss] ~= nil then
        kill(playerIndex)
        local playerClass = player:getClass()
        playerClass:changeBoss(selectedBoss)
        ACTIVE_BOSSES[playerIndex] = player
        --TODO: Refactor this so that it can handle all bosses. 
        --probably best to place this in one function.
        if selectedBoss == "torres" then
            newTorresEvent = EventItem:new()
            newTorresEvent:set({}, nil, NotifyPlayersCompleted, 30 * 26)
            EVENT_TABLE['TorresEvent'] = newTorresEvent
        end
    else
        say(playerIndex, "That boss does not exist!")
    end
end
function activateUltimateAbility(hash, playerIndex)
    if ACTIVE_PLAYER_LIST[hash]:getClass().cooldown == false then
        ACTIVE_PLAYER_LIST[hash]:getClass():ultimate(playerIndex)
    else
        say(playerIndex, "You can use your ultimate ability in " .. math.ceil(EVENT_TABLE[ACTIVE_PLAYER_LIST[hash]:getClass().cooldownStatus].time / 30) .. " seconds!")
    end
end
function unloadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    ACTIVE_PLAYER_LIST[hash] = nil
end

SavantEventCompleted = function(props) 
    say_all("Savant Deployed! It's near the center walkway!")
    spawn_object("weap", "halo reach\\objects\\weapons\\support_high\\spartan_laser\\savant", 105.62, 342.36, -3)
end

LocationEventCompleted = function(props) 
    say_all("Message Received. Savant Drop is on it's way!")
    savantEventComplete = EventItem:new()
    savantEventComplete:set({}, nil, SavantEventCompleted, 30 * 120)
    EVENT_TABLE["savantEventComplete"] = savantEventComplete
end

NotifyPlayersCompleted = function(props) 
    say_all("Be on the look out for a special computer!")
    locationEventComplete = EventItem:new()
    locationEventComplete:set({}, function(props, time)
        for i=1,16 do
            if player_present(i) then
                local hash = get_var(i, "$hash")
                if ACTIVE_PLAYER_LIST[hash]:isInLocation("torres_event_1") then
                    return true
                end
            end
        end
        return false
    end, LocationEventCompleted, -1)
    EVENT_TABLE["LocationEventTorres"] = locationEventComplete
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
function ClearConsole(i)
	for j=0,25 do
		rprint(i, " ")
	end
end

function PrintHealthBar(currentHealth, maxHealth)
    local length = 65
	if currentHealth == -100 then
		currentHealth = maxHealth
	end
	local healthBar = ""
	for i=1,length do
		if i > currentHealth/maxHealth*length then
			healthBar = healthBar.."."
		else
    		healthBar = healthBar.."|"
		end
	end
	return healthBar
end

function pickColor(health, maxHealth)
    local healthRatio = health / maxHealth
    if healthRatio >= 0.75 then
        return "|nc15B500" --green
    elseif healthRatio >= 0.5 and healthRatio < 0.75 then
        return "|ncDBC900" --yellow
    elseif healthRatio >= 0.25 and healthRatio < 0.5 then
        return "|ncFC8003" --orange
    else
        return "|ncFC0303" --red
    end
end

function PrintBossBar()
    for key,_ in pairs(ACTIVE_BOSSES) do
        local currentBoss = ACTIVE_BOSSES[key]
        local currentBossInMemory = get_dynamic_player(key) 
        local currentBossMaxHealth = currentBoss:getClass().maxHealth 
        local currentBossHealth = 0
        if currentBossInMemory ~= 0 then
            currentBossHealth = read_float(currentBossInMemory + 0xE0)*currentBoss:getClass().maxHealth
        end
        local chosenColor = pickColor(currentBossHealth, currentBossMaxHealth)
        if player_alive(key) then
            for i=1,16 do
                if get_var(0, "$ticks")%5 == 1 then
                    if player_present(i) then
                        ClearConsole(i)
                        rprint(i, "|c"..string.upper(currentBoss:getClass().name, "$name").."'S HEALTH " .. math.floor(currentBossHealth) .. "/" .. currentBossMaxHealth ..chosenColor)
                        rprint(i, "|c<"..PrintHealthBar(currentBossHealth, currentBossMaxHealth)..">"..chosenColor)
                    end
                end
            end
        else
        end
    end
end


function modifyDamage(attackingPlayer, playerTakingDamage, damage)
    local newDamage = damage
    for inventoryItem,_ in pairs(attackingPlayer) do
        print(inventoryItem)
        newDamage = newDamage * attackingPlayer[inventoryItem].modifier
        print(newDamage)
    end
    -- for inventoryItem,_ in pairs(playerTakingDamage) do
    --     newDamage = newDamage * playerTakingDamage[inventoryItem].modifier
    -- end
    return newDamage
end
function loadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new()
    newPlayer:setClass(DpsSchema:new())
    newPlayer:setPlayerIndex(playerIndex)
    ACTIVE_PLAYER_LIST[hash] = newPlayer
end

--Callbacks
function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    register_callback(cb['EVENT_JOIN'], "handleJoin")
    register_callback(cb['EVENT_LEAVE'], "handleLeave")
    register_callback(cb['EVENT_DAMAGE_APPLICATION'], "handleDamage")
    register_callback(cb['EVENT_OBJECT_SPAWN'], "handleSpawn")
    register_callback(cb['EVENT_TICK'], "handleTick")
    register_callback(cb['EVENT_DIE'], "handlePlayerDie")
    register_callback(cb['EVENT_AREA_ENTER'], "handleAreaEnter")
    register_callback(cb['EVENT_AREA_EXIT'], "handleAreaExit")
    register_callback(cb['EVENT_PRESPAWN'], "handlePrespawn")
    register_callback(cb['EVENT_GAME_END'],"OnGameEnd")
    for i=1,16 do
        if(player_present(i)) then
            loadPlayer(i)
            kill(i)
        end
    end
end


function OnScriptUnload()
    unregister_callback(cb['EVENT_COMMAND'])
    unregister_callback(cb['EVENT_JOIN'])
    unregister_callback(cb['EVENT_LEAVE'])
    unregister_callback(cb['EVENT_DAMAGE_APPLICATION'])
    unregister_callback(cb['EVENT_OBJECT_SPAWN'])
    unregister_callback(cb['EVENT_TICK'])
    unregister_callback(cb['EVENT_DIE'])
    unregister_callback(cb['EVENT_AREA_ENTER'])
    unregister_callback(cb['EVENT_AREA_EXIT'])
    unregister_callback(cb['EVENT_PRESPAWN'])
    unregister_callback(cb['EVENT_GAME_END'])
    BIPED_TAG_LIST = {}
    ACTIVE_PLAYER_LIST = {}
    ACTIVE_BOSSES = {}
    EVENT_TABLE = {}
end

OnGameEnd = OnScriptUnload

function handlePrespawn(playerIndex)
    if player_present(playerIndex) then
        local hash = get_var(playerIndex, "$hash")
        local currentPlayer = ACTIVE_PLAYER_LIST[hash]
        if currentPlayer:getClass().boss then
            execute_command("t ".. tostring(playerIndex) .." ".. tostring(currentPlayer:getClass().name))
        end
    end
end

function handleAreaEnter(playerIndex, areaEntered) 
    if player_present(playerIndex) then
        local hash = get_var(playerIndex, "$hash")
        local player = ACTIVE_PLAYER_LIST[hash]
        say(playerIndex, "You approach " .. LOCATIONS[areaEntered])
        player:setLocation(areaEntered)
    end
end

function handleAreaExit(playerIndex, areaExited) 
    if player_present(playerIndex) then 
        local hash = get_var(playerIndex, "$hash")
        local player = ACTIVE_PLAYER_LIST[hash]
        say(playerIndex, "You walk away from " .. LOCATIONS[areaExited])
        player:removeLocation(areaExited)
    end
end

--TODO: Dequeue ultimate if player dies
function handlePlayerDie(playerIndex, causer)
    if(player_present(playerIndex)) then
        local hash = get_var(playerIndex, "$hash")
        local playerClass = ACTIVE_PLAYER_LIST[hash]:getClass()
        if playerClass.boss then
            ACTIVE_BOSSES[playerIndex] = nil
            playerClass.name = "DEFAULT"
        end
    end
end

function handleDamage(playerIndex, damagerPlayerIndex, damageTagId, Damage, CollisionMaterial, Backtap)
    --TODO: Refactor this into a damage function, that funnels through all players and handles damage accordingly. 
    if player_present(playerIndex) and player_present(damagerPlayerIndex) then
        local attackingPlayer = ACTIVE_PLAYER_LIST[get_var(damagerPlayerIndex, "$hash")]:getPlayerInventory()
        local player = ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]:getPlayerInventory()
        local newDamage = modifyDamage(attackingPlayer, player, Damage)
        if playerIndex == damagerPlayerIndex then 
            say(playerIndex, "You dealt " .. newDamage .. " damage to yourself, you goober!")
        else
            say(playerIndex, "You were dealt " .. newDamage .. " damage!")
            say(damagerPlayerIndex, "You dealt " .. newDamage .. " damage!")
        end
        return true,newDamage
    end
    return true
end

function handleTick()
    PrintBossBar()
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
        local currentPlayer = ACTIVE_PLAYER_LIST[hash]
        local maxHealth = currentPlayer:getClass().maxHealth
        if maxHealth ~= nil and maxHealth ~= 0 then
            local playerGuard = get_dynamic_player(playerIndex)
            if playerGuard ~= 0 then
                write_float(playerGuard + 0xD8, maxHealth)
            end
        end
        return true,BIPED_TAG_LIST[currentPlayer:getClass().name]
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