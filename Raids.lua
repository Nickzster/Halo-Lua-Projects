api_version="1.10.1.0"

BIPED_DIR_LIST = { 
    ["dps"]="characters\\cyborg_mp\\dps",
    ["healer"]="characters\\cyborg_mp\\healer",
    ["tank"]="zteam\\objects\\characters\\spartan\\h3\\tank",
    ["bandolier"]="bourrin\\halo reach\\marine-to-spartan\\bandolier",
    ["gunslinger"]="np\\objects\\characters\\elite\\h3\\bipeds\\gunslinger",
    ["scourge"]="h2spp\\characters\\flood\\juggernaut\\scourge",
    ["torres"]="rangetest\\cmt\\characters\\evolved_h1-spirit\\cyborg\\bipeds\\torres",
    ["eliminator"]="rangetest\\cmt\\characters\\spv3\\forerunner\\enforcer\\bipeds\\eliminator",
    ["kreyul"]="shdwslyr\\reach_elite\\ultra\\kreyul",
    ["gordius"]="cmt\\characters\\evolved\\covenant\\hunter\\bipeds\\gordius"
}



LOCATIONS= {
    ["torres_event_1"] = "an important computer!"
}

BIPED_TAG_LIST = {}

ACTIVE_PLAYER_LIST = {}

ACTIVE_BOSSES = {}

-- MOVED TO Raids.modules.events.EventTable
-- EVENT_TABLE = {}




EventItem = {
    time=nil,
    completedCb=nil,
    eachTickCb=nil,
    props=nil
}

function EventItem.getRemainingTime(self)
    return self.time 
end


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


EventItem = {
    time=nil,
    completedCb=nil,
    eachTickCb=nil,
    props=nil
}

function EventItem.getRemainingTime(self)
    return self.time 
end


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



--singleton
EventTable = {}

function EventTable.addEvent(self, eventKey, newEvent) 
    EventTable[eventKey] = newEvent
end

function EventTable.getEvent(self, eventKey)
    return EventTable[eventKey]
end

function EventTable.removeEvent(self, eventKey) 
    EventTable[eventKey] = nil
end

function EventTable.cycle(self) 
    for key,_ in pairs(EventTable) do
        if EventTable[key] ~= EventTable.addEvent 
        and EventTable[key] ~= EventTable.removeEvent 
        and EventTable[key] ~= EventTable.cycle
        and EventTable[key] ~= EventTable.getEvent then
            if EventTable[key]:isTimedOut() == true then
                EventTable:removeEvent(key)
            end
        end
    end
end
--types
-- WEAPON- A reference to a weapon file
-- OUTPUT_DAMAGE: Multiplies the incoming base damage for a weapon by the modifier amount, and adds it to the base damage value.
-- INPUT_DAMAGE: Multiplies the incoming base damage for a weapon by the modifier amount, and subtracts it from the base damage value.
-- INVINCIBILITY: Specifies the length of invunerability the item has in ticks.
-- IGNORE: Specifies the upper bounds of the RNG to ignore damage.
-- HEAL: Specifies the amount of health to regenerate every second.

ITEM_LIST = {
    piercer={
        description="Battle Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
        modifier=612,
        classes={
            dps=true
        }
    },
    reliable={
        description="Assault Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable",
        modifier=640,
        classes={
            dps=true
        }
    },
    accelerator={
        description="MA5K",
        type="WEAPON",
        dir="altis\\weapons\\br\\accelerator",
        modifier=640,
        classes={
            bandolier=true
        }
    },
    limitless={
        description="MG",
        type="WEAPON",
        dir="rangetest\\cmt\\weapons\\spv3\\human\\turret\\limitless",
        modifier=500,
        classes={
            bandolier=true
        }
    },
    discordant={
        description="Concussion Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\concussion_rifle\\hr\\discordant",
        modifier=594,
        classes={
            gunslinger=true
        }
    },
    irradiator={
        description="Carbine",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\covenant_carbine\\h3\\irradiator",
        modifier=612,
        classes={
            gunslinger=true
        }
    },
    brassknuckle={
        description="Mauler",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\mauler\\h3\\brassknuckle",
        modifier=495,
        classes={
            tank=true
        }
    },
    rampart={
        description="Spiker",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\spike_rifle\\h3\\rampart",
        modifier=920,
        classes={
            tank=true
        }
    },
    faithful={
        description="Plasma Pistol",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\plasma_pistol\\h3\\faithful",
        modifier=100,
        classes={
            healer=true
        }
    },
    lightbringer={
        description="Plasma Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\plasma_rifle\\h3\\lightbringer",
        modifier=100,
        classes={
            healer=true
        }
    },
    armor_piercing={
        description="Increases your damage output",
        type="OUTPUT_DAMAGE",
        dir=nil,
        modifier=0.4,
        classes=nil
    },
    armor={
        description="Reduces the damage you take",
        type="INPUT_DAMAGE",
        dir=nil,
        modifier=0.4,
        classes=nil
    }
}

--function definitions
new = function(self)
    local newClassInstance = {}
    setmetatable(newClassInstance, self)
    self.__index = self
    return newClassInstance
end

setClass = function(self, class)
    self.class = class
    return self.class
end

getClass = function(self)
    return self.class
end

getClassName = function(self)
    return self.name
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
    EventTable:addEvent(key, newEventItem)
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
    name=nil,
    description=nil,
    type=nil,
    dir=nil,
    modifier=nil
}

ItemSchema['new'] = new

function ItemSchema:destroyItem() end

function ItemSchema.createItem(self, name, description, type, dir, modifier) 
    self.name = name
    self.description = description
    self.type = type
    --TODO: Reimplement this in a different function or scope.
    -- if self.type == "HEAL" then
    --     local key = 'HEALING_MODIFIER_FOR_PLAYER_' ..playerIndex
    --     local newHealthRegenModifier = EventItem:new()
    --     newHealthRegenModifier:set({
    --         ['playerIndex'] = playerIndex
    --     }, function (props, time)
    --         --TODO: Implement health modifier here
    --     end, function(props)
    --         --TODO: Implement a complete method here
    --     end, -1)
    --     EVENT_TABLE[key] = newHealthRegenModifier
    --     self.key = key
    -- end
    self.dir = dir
    self.modifier = modifier
    return self
end

function ItemSchema.getName(self)
    return self.name
end

function ItemSchema.getRef(self)
    if self.dir ~= nil then return self.dir else return nil end
end

function ItemSchema.getDescription(self)
    return self.description
end

function ItemSchema.getModifier(self)
    if self.modifier ~= nil then return self.modifier else return nil end
end

function ItemSchema.getType(self)
    if self.type ~= nil then return self.modifier else return nil end
end


PlayerSchema = {
    playerIndex=nil,
    loadouts={
        dps = { 
            primary="piercer",
            secondary="reliable"
        },
        bandolier={
                primary="limitless",
                secondary="accelerator"
        },
        gunslinger={
            primary="irradiator",
            secondary="discordant"
        },
        healer={
            primary="lightbringer",
            secondary="faithful"
        },
        tank={
            primary="brassknuckle",
            secondary="rampart"
        },
    },
    inventory={
        piercer="piercer",
        reliable="reliable",
        limitless="limitless",
        accelerator="accelerator",
        irradiator="irradiator",
        discordant="discordant",
        lightbringer="lightbringer",
        faithful="faithful",
        brassknuckle="brassknuckle",
        rampart="rampart"
    },
    equipment=nil,
    locations={},
    preferredClass=nil,
    class=nil
}

function PlayerSchema.getPreferredClass(self)
    return self.preferredClass 
end

function PlayerSchema.setPreferredClass(self, newClass)
    self.preferredClass = newClass
end

function PlayerSchema.isInLocation(self, location)
    if self.locations[location] ~= nil then return true else return false end
end

function PlayerSchema.setLocation(self, newLocation)
    self.locations[newLocation] = newLocation
end

function PlayerSchema.removeLocation(self, location)
    self.locations[location] = nil
end

function PlayerSchema.addItemToInventory(self, itemName)
    --TODO: Refactor
    if ITEM_LIST[itemName] then
        local newItem = ItemSchema:new()
        newItem:createItem(itemName, ITEM_LIST[itemName].description, ITEM_LIST[itemName].type, ITEM_LIST[itemName].modifier, self.playerIndex)
        self.inventory[itemName] = newItem
        say(self.playerIndex, "New Item: " ..itemName.. " has been added to your inventory!")
        return true
    else
        return false
    end
end

function PlayerSchema.getItemFrominventory(self, item)
    if self.inventory[item] then return self.inventory[item] else return nil end
end

function setInventoryTable(self, newTable)
    self.inventory = newTable
end

function PlayerSchema.removeItemFromInventory(self,itemName)
    self.inventory[itemName] = nil
end

function PlayerSchema.getInventory(self)
    return self.inventory
end

function PlayerSchema.addUnlock(self,weaponName)
    if WEAPON_DIR_LIST[weaponName] then
        self.unlocks[weaponName] = weaponName
    end
end

function PlayerSchema.setPlayerIndex(self,playerIndex)
    self.playerIndex = playerIndex
end

function PlayerSchema.setEquipment(self, newEquipment)
    self.equipment = newEquipment
end

function PlayerSchema.getEquipment(self)
    return self.equipment
end

function PlayerSchema.getClassNameUtil(self, className)
    if className == nil then
        return self:getClass():getClassName()
    end
    return className
end

function PlayerSchema.getPrimaryWeapon(self, class)
    return self.loadouts[self:getClassNameUtil(class)].primary
end

function PlayerSchema.getSecondaryWeapon(self, class)
    return self.loadouts[self:getClassNameUtil(class)].secondary
end

function PlayerSchema.setLoadout(self, class, newPrimary, newSecondary)
    self.loadouts[self:getClassNameUtil(class)].primary = newPrimary
    self.loadouts[self:getClassNameUtil(class)].secondary = newSecondary
end

function PlayerSchema.setLoadoutTable(self, newLoadoutTable)
    self.loadouts = newLoadoutTable
end



PlayerSchema['new'] = new
PlayerSchema['getClass'] = getClass
PlayerSchema['setClass'] = setClass
function GetPlayerDistance(index1, index2)
	local p1 = get_dynamic_player(index1)
	local p2 = get_dynamic_player(index2)
	
	return math.sqrt((read_float(p2+0x5C  ) - read_float(p1+0x5C  ))^2
	                +(read_float(p2+0x5C+4) - read_float(p1+0x5C+4))^2
	                +(read_float(p2+0x5C+8) - read_float(p1+0x5C+8))^2)
end
BossHealthValues = {
    ["DEFAULT"] = 1000,
    ["scourge"] = 5000,
    ["torres"] = 1500,
    ["eliminator"] = 2000,
    ["kreyul"] = 1000,
    ["gordius"]=4000
}

BossSchema = {
    name="DEFAULT",
    boss=true,
    maxHealth=100
}

BossSchema['getMaxHealth'] = function(self)
    return self.maxHealth
end

BossSchema['getClassName'] = getClassName
BossSchema['isBoss'] = function(self)
    return self.boss
end
BossSchema['new'] = new
BossSchema['changeBoss'] = function(self, newBiped)
    self.name = newBiped
    self.maxHealth = BossHealthValues[newBiped]
end

GUNSLINGER_COOLDOWN_IN_SECONDS = 120

GunslingerSchema = {
    name="gunslinger",
    cooldown = false,
    cooldownTime = GUNSLINGER_COOLDOWN_IN_SECONDS * 30,
    maxHealth = 100,
}


GunslingerSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Engaging active camoflage!")
    execute_command('camo ' .. playerIndex .. " " .. 30)
    self:startCoolDown(playerIndex)
end

GunslingerSchema['getClassName'] = getClassName
GunslingerSchema['startCoolDown'] = startCoolDown
GunslingerSchema['cooldownMessage'] = cooldownMessage
GunslingerSchema['endCoolDown'] = endCoolDown
GunslingerSchema['new'] = new
function savePlayer(hash)
    local currentPlayer = ACTIVE_PLAYER_LIST[hash]
    local fileName = "raids_data_files/"..hash
    if currentPlayer:getClass().boss then
        print("detected a boss player... skipping them!")
    else
        local file = io.open(fileName, "w")
        if file == nil then
            print("ERROR: raids_data_files DOES NOT EXIST. CREATE IT IN ORDER TO SAVE PLAYER DATA!")
        else
            local classNames = {
                dps='DPS',
                healer='HEALER',
                bandolier='BANDOLIER',
                tank='TANK',
                gunslinger='GUNSLINGER'
            }
            for key,_ in pairs(classNames) do
                file:write("$"..classNames[key] .. "_LOADOUT_BEGIN\n")
                if currentPlayer:getPrimaryWeapon(key).getName == nil then
                    file:write(currentPlayer:getPrimaryWeapon(key).."\n")
                else
                    file:write(currentPlayer:getPrimaryWeapon(key):getName().."\n")
                end
                if currentPlayer:getSecondaryWeapon(key).getName == nil then
                    file:write(currentPlayer:getSecondaryWeapon(key).."\n")
                else
                    file:write(currentPlayer:getSecondaryWeapon(key):getName().."\n")
                end
                file:write("$"..classNames[key] .. "_LOADOUT_END\n")
            end
            file:write("$EQUIPMENT_BEGIN\n")
            if currentPlayer:getEquipment() ~= nil then
                file:write(currentPlayer:getEquipment():getName().."\n")
            end
            file:write("$EQUIPMENT_END\n")
            local playerInventory = currentPlayer:getInventory()
            file:write("$INVENTORY_BEGIN\n")
            for key,_ in pairs(playerInventory) do
                file:write(key.."\n")
            end
            file:write("$INVENTORY_END\n")
            file:write("$PREFERRED_CLASS_BEGIN\n")
            file:write(currentPlayer:getPreferredClass()..'\n')
            file:write("$PREFERRED_CLASS_END\n")
            file:write("$EOF")
            file:close()
        end
    end
end

function unloadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    savePlayer(hash)
    ACTIVE_PLAYER_LIST[hash] = nil
end

TANK_COOLDOWN_IN_SECONDS = 100

TankSchema = {
    name="tank",
    cooldown=false,
    cooldownTime = TANK_COOLDOWN_IN_SECONDS * 30,
    maxHealth=500,
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
    EventTable:addEvent(key, ungodEvent)
end

TankSchema['getClassName'] = getClassName
TankSchema['startCoolDown'] = startCoolDown
TankSchema['coolDownMessage'] = coolDownMessage
TankSchema['endCoolDown'] = endCoolDown
TankSchema['new'] = new


HEALER_COOLDOWN_IN_SECONDS = 75

HealerSchema = {
    name="healer",
    cooldown=false,
    cooldownTime = HEALER_COOLDOWN_IN_SECONDS * 30,
    maxHealth=100,
 }

 HealerSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Healing nearby players!")
    for i=0,16 do 
        if player_present(i) 
        and ACTIVE_BOSSES[i] == nil
        and GetPlayerDistance(playerIndex, i) <= 5 
        or i == playerIndex then
            execute_command("hp " .. i .. " 1.0")
        end
    end
    self:startCoolDown(playerIndex)
end


HealerSchema['getClassName'] = getClassName
HealerSchema['startCoolDown'] = startCoolDown
HealerSchema['coolDownMessage'] = coolDownMessage
HealerSchema['endCoolDown'] = endCoolDown
HealerSchema['new'] = new
DPS_COOLDOWN_IN_SECONDS = 70

DpsSchema = {
    name="dps",
    cooldown=false,
    cooldownTime = DPS_COOLDOWN_IN_SECONDS * 30,
    maxHealth=100,
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
    EventTable:addEvent(key, newEvent)
end

DpsSchema['getClassName'] = getClassName
DpsSchema['startCoolDown'] = startCoolDown
DpsSchema['coolDownMessage'] = coolDownMessage
DpsSchema['endCoolDown'] = endCoolDown
DpsSchema['new'] = new
BANDOLIER_COOLDOWN_IN_SECONDS = 75

BandolierSchema = {
    name="bandolier",
    cooldown=false,
    cooldownTime = BANDOLIER_COOLDOWN_IN_SECONDS * 30,
    maxHealth = 100,
}

BandolierSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "Giving all nearby players ammo!")
    for i=0, 16 do
        if player_present(i) 
        and ACTIVE_BOSSES[i] == nil 
        and GetPlayerDistance(playerIndex, i) <= 5
        or i == playerIndex then
            local currentPlayer = ACTIVE_PLAYER_LIST[get_var(i, "$hash")]
            execute_command("ammo " .. i .. " " .. currentPlayer:getPrimaryWeapon():getModifier() .. " 3")
            execute_command("ammo " .. i .." " .. currentPlayer:getSecondaryWeapon():getModifier() .. " 4")
            execute_command("battery " .. i .. " 100 5")
        end
    end
    self:startCoolDown(playerIndex)
end

BandolierSchema['getClassName'] = getClassName
BandolierSchema['startCoolDown'] = startCoolDown
BandolierSchema['coolDownMessage'] = coolDownMessage
BandolierSchema['endCoolDown'] = endCoolDown
BandolierSchema['new'] = new
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
        local currentPlayer = ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]
        currentPlayer:setClass(CLASS_LIST[newClass]:new())
        if newClass == "boss" then
            currentPlayer:setPreferredClass('dps')
        else
            currentPlayer:setPreferredClass(newClass)
            local primaryWeapon = currentPlayer:getPrimaryWeapon(newClass)
            local secondaryWeapon = currentPlayer:getSecondaryWeapon(newClass)
            if primaryWeapon.getName == nil then
                local pkey = primaryWeapon
                primaryWeapon = ItemSchema:new():createItem(
                    pkey,
                    ITEM_LIST[pkey].description, 
                    ITEM_LIST[pkey].type, 
                    ITEM_LIST[pkey].dir, 
                    ITEM_LIST[pkey].modifier
                )
            end
            if secondaryWeapon.getName == nil then
                local skey = secondaryWeapon
                secondaryWeapon = ItemSchema:new():createItem(
                    skey,
                    ITEM_LIST[skey].description, 
                    ITEM_LIST[skey].type, 
                    ITEM_LIST[skey].dir, 
                    ITEM_LIST[skey].modifier
                )
            end
            currentPlayer:setLoadout(newClass, primaryWeapon, secondaryWeapon)
            savePlayer(get_var(playerIndex, "$hash"))
        end
        if player_alive(playerIndex) then kill(playerIndex) end
        return true
    else
        say(playerIndex, "That class does not exist!")
        return false
    end
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

function loadPlayer(playerIndex) 
    local playerClass = 'dps'
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new()
    newPlayer:setPlayerIndex(playerIndex)
    --step one: Read from database
    --TODO: Implement Database Logic
    local fileName = "raids_data_files/"..hash
    local file = io.open(fileName, "r")
    if file ~= nil then
        local EOF = false
        while EOF == false do
            local nextLine = file:read("*l")
            if nextLine == "$DPS_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                newPlayer:setLoadout('dps', p, s)
                file:read("*l")
            end
            if nextLine == "$HEALER_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                newPlayer:setLoadout('healer', p, s)
                file:read("*l")
            end
            if nextLine == "$TANK_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                newPlayer:setLoadout('tank', p, s)
                file:read("*l")
            end
            if nextLine == "$GUNSLINGER_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                newPlayer:setLoadout('gunslinger', p, s)
                file:read("*l")
            end
            if nextLine == "$BANDOLIER_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                newPlayer:setLoadout('bandolier', p, s)
                file:read("*l")
            end
            if nextLine == "$EQUIPMENT_BEGIN" then
                local ekey = file:read("*l")
                if ekey ~= "$EQUIPMENT_END" then
                    newPlayer:setEquipment(ekey, ItemSchema:new():createItem(
                        ekey,
                        ITEM_LIST[ekey].description,
                        ITEM_LIST[ekey].type,
                        ITEM_LIST[ekey].dir,
                        ITEM_LIST[ekey].modifier
                    ))
                    file:read("*l")
                end
            end
            if nextLine=="$INVENTORY_BEGIN" then
                local currentInventoryItem = file:read("*l")
                while currentInventoryItem ~= "$INVENTORY_END" do
                    newPlayer:addItemToInventory(currentInventoryItem)
                    currentInventoryItem = file:read("*l")
                end
            end
            if nextLine=="$PREFERRED_CLASS_BEGIN" then
                playerClass = file:read("*l")
                file:read("*l")
            end
            if nextLine=="$EOF" then
                EOF = true
            end
        end
        file:close()
    end
    --step two: initalize values, load player
    ACTIVE_PLAYER_LIST[hash] = newPlayer
    changePlayerClass(playerIndex, playerClass)
end
function modifyDamage(attackingEquipment, damagedEquipment, damage)
    local newDamage = damage
    if attackingEquipment ~= nil and attackingEquipment:getType() == "OUTPUT_DAMAGE" then
        newDamage = newDamage + (newDamage * attackingEquipment:getModifier())
    end
    if damagedEquipment ~= nil then
        if damagedEquipment:getType() == "INPUT_DAMAGE" then
            newDamage = newDamage - (newDamage * damagedEquipment:getModifier())
        elseif damagedEquipment:getType() == "INVINCIBILITY" then
            --TODO: Refactor this properly in future
            newDamage = newDamage - (newDamage * damagedEquipment:getModifier())
        elseif damagedEquipment:getType() == "IGNORE" then
            local random = math.random(1, damagedEquipment:getModifier())
            if random == 1 then newDamage = 0 end
        end
    end
    return newDamage
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
            local weap = spawn_object("weap", "zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer", 102.23, 417.59, 5)
            assign_weapon(weap, tonumber(playerIndex))
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
            EventTable:addEvent('TorresEvent', newTorresEvent)
        end
    else
        say(playerIndex, "That boss does not exist!")
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


SavantEventCompleted = function(props) 
    say_all("Savant Deployed! It's near the center walkway!")
    spawn_object("weap", "halo reach\\objects\\weapons\\support_high\\spartan_laser\\savant", 105.62, 342.36, -3)
end

LocationEventCompleted = function(props) 
    say_all("Message Received. Savant Drop is on it's way!")
    savantEventComplete = EventItem:new()
    savantEventComplete:set({}, nil, SavantEventCompleted, 30 * 120)
    EventTable:addEvent('savantEventComplete', savantEventComplete)
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
    EventTable:addEvent("LocationEventTorres", locationEventComplete)
end


function activateUltimateAbility(hash, playerIndex)
    if ACTIVE_PLAYER_LIST[hash]:getClass().cooldown == false then
        ACTIVE_PLAYER_LIST[hash]:getClass():ultimate(playerIndex)
    else
        local remainingTime = EventTable:getEvent(ACTIVE_PLAYER_LIST[hash]:getClass():getClassName()..playerIndex):getRemainingTime()
        say(playerIndex, "You can use your ultimate ability in " .. math.ceil(remainingTime / 30) .. " seconds!")
    end
end

--Callbacks

function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    register_callback(cb['EVENT_JOIN'], "handleJoin")
    register_callback(cb['EVENT_LEAVE'], "handleLeave")
    register_callback(cb['EVENT_DAMAGE_APPLICATION'], "handleDamage")
    register_callback(cb['EVENT_OBJECT_SPAWN'], "handleObjectSpawn")
    register_callback(cb['EVENT_SPAWN'], "handleSpawn")
    register_callback(cb['EVENT_TICK'], "handleTick")
    register_callback(cb['EVENT_DIE'], "handlePlayerDie")
    register_callback(cb['EVENT_AREA_ENTER'], "handleAreaEnter")
    register_callback(cb['EVENT_AREA_EXIT'], "handleAreaExit")
    register_callback(cb['EVENT_PRESPAWN'], "handlePrespawn")
    register_callback(cb['EVENT_GAME_END'],"OnGameEnd")
    register_callback(cb['EVENT_GAME_START'], "OnGameStart")
    for i=1,16 do
        if(player_present(i)) then
            loadPlayer(i)
            kill(i)
        end
    end
end

function OnScriptUnload()
    -- unregister_callback(cb['EVENT_COMMAND'])
    -- unregister_callback(cb['EVENT_JOIN'])
    -- unregister_callback(cb['EVENT_LEAVE'])
    -- unregister_callback(cb['EVENT_DAMAGE_APPLICATION'])
    -- unregister_callback(cb['EVENT_OBJECT_SPAWN'])
    -- unregister_callback(cb['EVENT_TICK'])
    -- unregister_callback(cb['EVENT_DIE'])
    -- unregister_callback(cb['EVENT_AREA_ENTER'])
    -- unregister_callback(cb['EVENT_AREA_EXIT'])
    -- unregister_callback(cb['EVENT_PRESPAWN'])
    -- unregister_callback(cb['EVENT_GAME_END'])
    -- unregister_callback(cb['EVENT_GAME_START'])
    BIPED_TAG_LIST = {}
    ACTIVE_PLAYER_LIST = {}
    ACTIVE_BOSSES = {}
    EVENT_TABLE = {}
end

OnGameStart = OnScriptLoad

OnGameEnd = OnScriptUnload

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
        local attackingPlayerEquipment = ACTIVE_PLAYER_LIST[get_var(damagerPlayerIndex, "$hash")]:getEquipment()
        local damagedPlayerEquipment = ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]:getEquipment()
        local newDamage = modifyDamage(attackingPlayerEquipment, damagedPlayerEquipment, Damage)
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
    EventTable:cycle()
end

function handleObjectSpawn(playerIndex, tagId, parentObjectId, newObjectId)
    if BIPED_TAG_LIST['DEFAULT'] == nil then 
        loadBipeds() 
    end
    if player_present(playerIndex) and tagId == BIPED_TAG_LIST['DEFAULT'] then 
        local hash = get_var(playerIndex, "$hash")
        local currentPlayer = ACTIVE_PLAYER_LIST[hash]
        if currentPlayer:getClass().getMaxHealth ~= nil then
            local maxHealth = currentPlayer:getClass():getMaxHealth()
            if maxHealth ~= 0 then
                local playerGuard = get_dynamic_player(playerIndex)
                if playerGuard ~= 0 then
                    write_float(playerGuard + 0xD8, maxHealth)
                end
            end
        end
        return true,BIPED_TAG_LIST[currentPlayer:getClass():getClassName()]
    end
end


function handlePrespawn(playerIndex)
    if player_present(playerIndex) then
        local hash = get_var(playerIndex, "$hash")
        local currentPlayer = ACTIVE_PLAYER_LIST[hash]
        if currentPlayer:getClass().boss then
            execute_command("t ".. tostring(playerIndex) .." ".. tostring(currentPlayer:getClass().name))
        end
    end
end

function handleSpawn(playerIndex)
    local hash = get_var(playerIndex, "$hash")
    local currentPlayer = ACTIVE_PLAYER_LIST[hash]
    if currentPlayer:getClass().isBoss == nil then
        execute_command('wdel ' .. playerIndex .. ' 5')
        assign_weapon(spawn_object("weap", currentPlayer:getPrimaryWeapon(currentPlayer:getClass():getClassName()):getRef()), tonumber(playerIndex))
        assign_weapon(spawn_object("weap", currentPlayer:getSecondaryWeapon(currentPlayer:getClass():getClassName()):getRef()), tonumber(playerIndex))
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