api_version="1.10.1.0"

LOCATIONS= {
    ["torres_event_1"] = "an important computer!"
}

BIPED_TAG_LIST = {}

ACTIVE_PLAYER_LIST = {}

NUMBER_OF_ALLOWED_TANKS = 1
NUMBER_OF_ALLOWED_HEALERS = 1
NUMBER_OF_ALLOWED_BANDOLIERS = 1
BOSS_MULTIPLIER = 1.0

ACTIVE_BOSSES = {}

-- MOVED TO Raids.modules.events.EventTable
-- EVENT_TABLE = {}




--function definitions
new = function(self, o)
    local newClassInstance = o or {}
    setmetatable(newClassInstance, self)
    self.__index = self
    return newClassInstance
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


ItemSchema = {
    name=nil,
    description=nil,
    ref=nil,
    classes={}
}

ItemSchema['new'] = new

function ItemSchema.createItem(self, name, description, ref, classes) 
    self.name = name
    self.description = description
    self.ref = ref
    self.classes = classes
    return self
end

function ItemSchema.getName(self)
    return self.name
end

function ItemSchema.getRef(self)
    return self.ref
end

function ItemSchema.getDescription(self)
    return self.description
end

function ItemSchema.isCompatible(self, className)
    if classes == nil or classes ~= nil and self.classes[className] == nil then return false end
    return true
end 


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
createWeapon = function(self, name, desc, ref, classes, maxAmmo, modifier)
    self:createItem(name, desc, ref, classes)
    self.maxAmmo = maxAmmo
    self.modifier = modifier
    return self 
end

getMaxAmmo = function(self)
    return self.maxAmmo
end

getModifier = function(self)
    return self.modifier
end


--types
-- WEAPON- A reference to a weapon file
-- DAMAGE_BOOST: Multiplies the incoming base damage for a weapon by the modifier amount, and adds it to the base damage value.
-- DAMAGE_REDUCE: Multiplies the incoming base damage for a weapon by the modifier amount, and subtracts it from the base damage value.
-- DAMAGE_INVINCIBILITY_PERIOD: Specifies the length of invunerability the item has in ticks.
-- DAMAGE_IGNORE: Specifies the upper bounds of the RNG to ignore damage.
-- HEAL: Specifies the amount of health to regenerate every second.

ITEM_LIST = {
    piercer={
        description="Battle Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
        maxAmmo=684,
        classes={
            dps=true
        }
    },
    reliable={
        description="Assault Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable",
        maxAmmo=676,
        classes={
            dps=true
        }
    },
    accelerator={
        description="MA5K",
        type="WEAPON",
        ref="altis\\weapons\\br\\accelerator",
        maxAmmo=676,
        classes={
            bandolier=true
        }
    },
    limitless={
        description="MG",
        type="WEAPON",
        ref="rangetest\\cmt\\weapons\\spv3\\human\\turret\\limitless",
        maxAmmo=600,
        classes={
            bandolier=true
        }
    },
    discordant={
        description="Concussion Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\concussion_rifle\\hr\\discordant",
        maxAmmo=606,
        classes={
            gunslinger=true
        }
    },
    irradiator={
        description="Carbine",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\covenant_carbine\\h3\\irradiator",
        maxAmmo=636,
        classes={
            gunslinger=true
        }
    },
    brassknuckle={
        description="Mauler",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\mauler\\h3\\brassknuckle",
        maxAmmo=505,
        classes={
            tank=true
        }
    },
    rampart={
        description="Spiker",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\spike_rifle\\h3\\rampart",
        maxAmmo=1000,
        classes={
            tank=true
        }
    },
    faithful={
        description="Plasma Pistol",
        type="WEAPON",
        battery=true,
        ref="zteam\\objects\\weapons\\single\\plasma_pistol\\h3\\faithful",
        maxBattery=100,
        classes={
            healer=true
        }
    },
    lightbringer={
        description="Plasma Rifle",
        type="WEAPON",
        battery=true,
        ref="zteam\\objects\\weapons\\single\\plasma_rifle\\h3\\lightbringer",
        maxBattery=100,
        classes={
            healer=true
        }
    },
    dpsstd={
        description="Standard ODST Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\dps",
        maxHealth=100,
        defense=0,
        classes={
            dps=true
        }
    },
    healerstd={
        description="Standard ODST armor for medics.",
        type="ARMOR",
        ref="characters\\cyborg_mp\\healer",
        maxHealth=100,
        defense=0,
        classes={
            healer=true
        }
    },
    tankstd={
        description="Standard MK 6 armor for tanks",
        type="ARMOR",
        ref="zteam\\objects\\characters\\spartan\\h3\\tank",
        maxHealth=500,
        defense=0,
        classes={
            tank=true
        }
    },
    bandolierstd={
        description="Standard Marine armor for Bandoliers",
        type="ARMOR",
        ref="bourrin\\halo reach\\marine-to-spartan\\bandolier",
        maxHealth=100,
        defense=0,
        classes={
            bandolier=true
        }
    },
    gunslingerstd={
        description="Standard Elite armor for Gunslingers",
        type="ARMOR",
        ref="np\\objects\\characters\\elite\\h3\\bipeds\\gunslinger",
        maxHealth=100,
        defense=0,
        classes={
            gunslinger=true
        }
    },
    scourge={
        description="Scourge Boss",
        type="BOSS",
        ref="h2spp\\characters\\flood\\juggernaut\\scourge",
        maxHealth=5000,
        defense=0,
        classes={
            boss=true
        }
    },
    torres={
        description="Torres Boss",
        type="BOSS",
        ref="rangetest\\cmt\\characters\\evolved_h1-spirit\\cyborg\\bipeds\\torres",
        maxHealth=1500,
        defense=0,
        classes={
            boss=true
        }
    },
    eliminator={
        description="Eliminator Boss",
        type="BOSS",
        ref="rangetest\\cmt\\characters\\spv3\\forerunner\\enforcer\\bipeds\\eliminator",
        maxHealth=2000,
        defense=0,
        classes={
            boss=true
        }
    },
    kreyul={
        description="Kreyul Boss",
        type="BOSS",
        ref="shdwslyr\\reach_elite\\ultra\\kreyul",
        maxHealth=1000,
        defense=0,
        classes={
            boss=true
        }
    },
    gordius={
        description="Gordius Boss",
        type="BOSS",
        ref="cmt\\characters\\evolved\\covenant\\hunter\\bipeds\\gordius",
        maxHealth=4000,
        defense=0,
        classes={
            boss=true
        }
    },
    DEFAULT={
        description="Default Map Biped",
        type="ARMOR",
        ref="characters\\cyborg\\cyborg",
        maxHealth=100,
        defense=0,
        classes={
            boss=true
        }
    },
    mightofgordius = {
        description="The Might of Gordius increases your damage!",
        type="DAMAGE_BOOST",
        modifier=0.1
    },
    shardofgordius = {
        description="The Shard of Gordius protects you from damage!",
        type="DAMAGE_REDUCE",
        modifier=0.1
    }
}

equip = function(self, name, description, ref, classes, modifier)
    self.name = name
    self.description = description
    self.ref = ref
    self.classes = classes
    self.modifier = modifier
    return self
end

getModifier = function(self)
    return self.modifier
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


AmmoWeapon = ItemSchema:new()

AmmoWeapon['createWeapon'] = createWeapon
AmmoWeapon['getMaxAmmo'] = getMaxAmmo
AmmoWeapon['getModifier'] = getModifier

function AmmoWeapon.setAmmo(self, playerIndex, weaponIndex)
    execute_command("ammo " .. playerIndex .. " " .. self:getMaxAmmo() .. " " .. weaponIndex)
end
ClassSchema = {
    name="BaseClass",
    cooldown=false,
    ultCooldownTime=0,
}

ClassSchema['new'] = new

function ClassSchema.ultimate(self, playerIndex)
    say(playerIndex, "This class does not have an ultimate!")
end

function ClassSchema.instantiate(self, name, cooldownTime)
    self.name = name
    self.ultCooldownTime = cooldownTime
    return self
end

function ClassSchema.getClassName(self)
    return self.name
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


function ClassSchema.startCoolDown(self, playerIndex)
    self.cooldown = true
    key = self.name .. playerIndex
    self.cooldownStatus = key
    newEventItem = EventItem:new()
    newEventItem:set({
        ['self']=self,
        ['playerIndex']=playerIndex
    }, coolDownMessage, endCoolDown, self.ultCooldownTime)
    EventTable:addEvent(key, newEventItem)
end




BatteryWeapon = ItemSchema:new()

BatteryWeapon['createWeapon'] = createWeapon
BatteryWeapon['getMaxAmmo'] = getMaxAmmo
BatteryWeapon['getModifier'] = getModifier

function BatteryWeapon.setAmmo(self, playerIndex, weaponIndex)
    execute_command("battery " .. playerIndex .. " 100 " .. weaponIndex)
end
ArmorSchema=ItemSchema:new()

function ArmorSchema.createArmor(self, name, desc, ref, classes, maxHealth, defense)
    self:createItem(name, desc, ref, classes)
    if type(maxHealth) == "number" then
        self.maxHealth = maxHealth
    elseif type(maxHealth) == "table" then
        if #ACTIVE_PLAYER_LIST >= 1 and #ACTIVE_PLAYER_LIST <=5 then
            self.maxHealth = maxHealth['small']
        elseif #ACTIVE_PLAYER_LIST >= 6 and #ACTIVE_PLAYER_LIST <= 10 then
            self.maxHealth = maxHealth['med']
        else 
            self.maxHealth = maxHealth['large']
        end
    end
    self.defense = defense
    return self
end

function ArmorSchema.setMaxHealth(self, newHealth)
    self.maxHealth = newHealth
end

function ArmorSchema.getDefense(self)
    return self.defense
end

function ArmorSchema.getMaxHealth(self)
    return self.maxHealth
end



DamageIgnoreSchema = ItemSchema:new()

function DamageIgnoreSchema.computeNewDamage(self,baseDamage)
    return baseDamage
end

DamageIgnoreSchema['equip'] = equip
DamageIgnoreSchema['getModifier'] = getModifier
PlayerSchema = {
    playerIndex=nil,
    loadouts=nil,
    inventory=nil,
    equipment=nil,
    locations=nil,
    preferredClass=nil,
    class=nil
}


function PlayerSchema.setClass(self, class)
    self.class = class
    return self.class
end

function PlayerSchema.setUpNewPlayer(self)
    for key,_ in pairs(self.loadouts) do
        local p = self.loadouts[key].primary
        local s = self.loadouts[key].secondary
        local a = self.loadouts[key].armor
        self:setLoadout(key, p, s)
        self:setArmor(key, a)
    end
end

function PlayerSchema.loadPlayer(self)
    self.locations = {}
    local startingLoadouts = {
        dps = { 
            primary="piercer",
            secondary="reliable",
            armor="dpsstd"
        },
        bandolier={
            primary="limitless",
            secondary="accelerator",
            armor="bandolierstd"
        },
        gunslinger={
            primary="irradiator",
            secondary="discordant",
            armor="gunslingerstd"
        },
        healer={
            primary="lightbringer",
            secondary="faithful",
            armor="healerstd"
        },
        tank={
            primary="brassknuckle",
            secondary="rampart",
            armor="tankstd"
        },
        boss={
            armor="DEFAULT"
        }
    }
    local startingInventory = {
        piercer="piercer",
        reliable="reliable",
        limitless="limitless",
        accelerator="accelerator",
        irradiator="irradiator",
        discordant="discordant",
        lightbringer="lightbringer",
        faithful="faithful",
        brassknuckle="brassknuckle",
        rampart="rampart",
        dps_std_armor = "dpsstd",
        healer_std_armor="healerstd",
        tank_std_armor="tankstd",
        bandolier_std_armor="bandolierstd",
        gunslinger_std_armor="gunslingerstd"
    }
    self.inventory = startingInventory
    self.loadouts = startingLoadouts
    return self
end

function PlayerSchema.savePlayer(self)
    local hash = get_var(self.playerIndex, "$hash")
    if hash ~= nil then WritePlayerToFile(hash) end
end

function PlayerSchema.getClass(self)
    return self.class
end

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
    if ITEM_LIST[itemName] and self:getItemFrominventory(itemName) == nil then
        self.inventory[itemName] = itemName
        say(self.playerIndex, "New Item: " ..itemName.. " has been added to your inventory!")
        return true
    else
        return false
    end
end

function PlayerSchema.getItemFrominventory(self, item)
    if self.inventory[item] then return self.inventory[item] else return nil end
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

function PlayerSchema.getPlayerIndex(self)
    return self.playerIndex
end

function PlayerSchema.setEquipment(self, newEquipmentKey)
    if ITEM_LIST[newEquipmentKey] ~= nil 
    and self:getItemFrominventory(newEquipmentKey) ~= nil
    then
        if ITEM_LIST[newEquipmentKey].classes == nil
        or ITEM_LIST[newEquipmentKey].classes ~= nil
        and ITEM_LIST[newEquipmentKey].classes[self:getClass():getClassName()] ~= nil
        then
            self.equipment = CreateEquipment(newEquipmentKey)
            say(self.playerIndex, "You have equipped " .. newEquipmentKey)
        else
            say(self.playerIndex, newEquipmentKey .. " is incompatible with " .. self:getClass():getClassName())
        end
    else
        say(self.playerIndex, "You have not unlocked " .. newEquipmentKey)
    end
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

function PlayerSchema.setLoadout(self, classKey, newPrimaryKey, newSecondaryKey)
    local currentClass = self:getClassNameUtil(classKey)
    --Ensure that the item exists
    if ITEM_LIST[newPrimaryKey] ~= nil and ITEM_LIST[newSecondaryKey] ~= nil then
        --Ensure that the item is a weapon
        if ITEM_LIST[newPrimaryKey].type ~= "WEAPON" or ITEM_LIST[newSecondaryKey].type ~= "WEAPON" then
            say(self:getPlayerIndex(), "You have specified an item that is NOT a weapon!")
            return false
        end
        --Ensure that the weapon is compatible with the class
        if ITEM_LIST[newPrimaryKey].classes ~= nil and ITEM_LIST[newPrimaryKey].classes[currentClass] == nil 
        or ITEM_LIST[newSecondaryKey].classes ~= nil and ITEM_LIST[newSecondaryKey].classes[currentClass] == nil then
            say(self:getPlayerIndex(), "You have specified a weapon that is NOT compatible with your class!")
            return false
        end
        self.loadouts[currentClass].primary = CreateWeapon(newPrimaryKey)
        self.loadouts[currentClass].secondary = CreateWeapon(newSecondaryKey)
        return true
    else
        if ITEM_LIST[newPrimary] == nil or ITEM_LIST[newSecondary] == nil then
            if currentClass ~= "boss" then
                say(self:getPlayerIndex(), "You have specified a loadout item that does NOT exist!")
            else
                self.loadouts[currentClass].primary = nil
                self.loadouts[currentClass].secondary = nil
            end
            return false
        end
    end
end

function PlayerSchema.setBoss(self, newBossKey)
    if ITEM_LIST[newBossKey] ~= nil and ITEM_LIST[newBossKey].type == "BOSS" or ITEM_LIST[newBossKey] == "ARMOR" then
        self.loadouts['boss'].armor = CreateArmor(newBossKey)
        self.loadouts['boss'].armor:setMaxHealth(self.loadouts['boss'].armor:getMaxHealth() * BOSS_MULTIPLIER)
    else
        say(self:getPlayerIndex(), "This boss either does not exist, or it is not loaded into the map!")
    end
end

function PlayerSchema.setArmor(self, classKey, newArmorKey)
    local currentClass = self:getClassNameUtil(classKey)
    if ITEM_LIST[newArmorKey] ~= nil then
        if ITEM_LIST[newArmorKey].type ~= "ARMOR" then
            say(self:getPlayerIndex(), "You have specified an item that is NOT armor!")
            return false
        end
        if ITEM_LIST[newArmorKey].classes[currentClass] == nil then
            say(self:getPlayerIndex(), "You have specified armor that is NOT compatible with your current class!")
            return false
        end
        self.loadouts[currentClass].armor = CreateArmor(newArmorKey)
        return true
    else
        say(self:getPlayerIndex(), "You have specified an armor item that does NOT exist!")
        return false
    end
end

function PlayerSchema.getArmor(self, key)
    return self.loadouts[self:getClassNameUtil(key)].armor
end


PlayerSchema['new'] = new
DamageBoosterSchema = ItemSchema:new()


function DamageBoosterSchema.computeNewDamage(self,baseDamage)
    return baseDamage + (baseDamage * self:getModifier())
end

DamageBoosterSchema['equip'] = equip
DamageBoosterSchema['getModifier'] = getModifier
function CreateEquipment(equipmentKey)
    if ITEM_LIST[equipmentKey].type == "DAMAGE_BOOST" then
        return DamageBoosterSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_REDUCE" then
        return DamageReductionSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_INVINCIBILITY" then
        return DamageInvPeriodSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_IGNORE" then
        return DamageIgnoreSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    elseif ITEM_LIST[equipmentKey].type == "HEAL" then
        return HealingSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    end
end
function CreateArmor(key)
    if ITEM_LIST[key] ~= nil
    and ITEM_LIST[key].type == "ARMOR"
    or ITEM_LIST[key].type == "BOSS"
    then
        return ArmorSchema:new():createArmor(
            key,
            ITEM_LIST[key].description,
            ITEM_LIST[key].ref,
            ITEM_LIST[key].classes,
            ITEM_LIST[key].maxHealth,
            ITEM_LIST[key].defense
        )
    else
        return nil
    end
end
HealingSchema = ItemSchema:new()

function HealingSchema.computeNewDamage(self,baseDamage)
    return baseDamage
end

function HealingSchema.activate(self) end

HealingSchema['equip'] = equip
HealingSchema['getModifier'] = getModifier
function CreateWeapon(key)
    if ITEM_LIST[key] ~= nil
    and ITEM_LIST[key].type == "WEAPON" 
    then
        if ITEM_LIST[key].battery ~= nil then
            return BatteryWeapon:new():createWeapon(
                key,
                ITEM_LIST[key].description,
                ITEM_LIST[key].ref,
                ITEM_LIST[key].classes,
                ITEM_LIST[key].maxAmmo,
                ITEM_LIST[key].modifier
            )
        else
            return AmmoWeapon:new():createWeapon(
                key,
                ITEM_LIST[key].description,
                ITEM_LIST[key].ref,
                ITEM_LIST[key].classes,
                ITEM_LIST[key].maxAmmo,
                ITEM_LIST[key].modifier
            )
        end
    else
        return nil
    end
end
DamageInvPeriod = ItemSchema:new()

function DamageInvPeriod.computeNewDamage(self,baseDamage)
    return baseDamage
end

DamageInvPeriod['equip'] = equip
DamageInvPeriod['getModifier'] = getModifier
DamageReductionSchema = ItemSchema:new()

function DamageReductionSchema.computeNewDamage(self,baseDamage)
    return baseDamage - (baseDamage * self:getModifier())
end

DamageReductionSchema['equip'] = equip
DamageReductionSchema['getModifier'] = getModifier
function GetPlayerDistance(index1, index2)
	local p1 = get_dynamic_player(index1)
	local p2 = get_dynamic_player(index2)
	
	return math.sqrt((read_float(p2+0x5C  ) - read_float(p1+0x5C  ))^2
	                +(read_float(p2+0x5C+4) - read_float(p1+0x5C+4))^2
	                +(read_float(p2+0x5C+8) - read_float(p1+0x5C+8))^2)
end

BossSchema=ClassSchema:new():instantiate("boss", 0)

function BossSchema.new(self)
    local newInstance = ClassSchema:new():instantiate("boss", 0, 0)
    return new(self, newInstance)
end
function WritePlayerToFile(hash)
    local currentPlayer = ACTIVE_PLAYER_LIST[hash]
    local fileName = "raids_data_files/"..hash
    local file = io.open(fileName, "w")
    if file == nil then
        print("ERROR: raids_data_files DOES NOT EXIST. CREATE IT IN ORDER TO SAVE PLAYER DATA!")
    else
        local classNames = {
            dps='DPS',
            healer='HEALER',
            bandolier='BANDOLIER',
            tank='TANK',
            gunslinger='GUNSLINGER',
            boss="BOSS"
        }
        for key,_ in pairs(classNames) do
            if key == "boss" then
                file:write("$BOSS_LOADOUT_BEGIN\n")
                file:write(currentPlayer:getArmor(key):getName().."\n")
                file:write("$BOSS_LOADOUT_END\n")
            else
                file:write("$"..classNames[key] .. "_LOADOUT_BEGIN\n")
                file:write(currentPlayer:getPrimaryWeapon(key):getName().."\n")
                file:write(currentPlayer:getSecondaryWeapon(key):getName().."\n")
                file:write(currentPlayer:getArmor(key):getName().."\n") 
                file:write("$"..classNames[key] .. "_LOADOUT_END\n")
            end
        end
        local playerInventory = currentPlayer:getInventory()
        file:write("$INVENTORY_BEGIN\n")
        for key,_ in pairs(playerInventory) do
            file:write(key.."\n")
        end
        file:write("$INVENTORY_END\n")
        file:write("$EQUIPMENT_BEGIN\n")
        if currentPlayer:getEquipment() ~= nil then
            file:write(currentPlayer:getEquipment():getName().."\n")
        end
        file:write("$EQUIPMENT_END\n")
        file:write("$PREFERRED_CLASS_BEGIN\n")
        file:write(currentPlayer:getPreferredClass()..'\n')
        file:write("$PREFERRED_CLASS_END\n")
        file:write("$EOF")
        file:close()
    end
end
function Balancer()
    local numberOfPlayers = #ACTIVE_PLAYER_LIST
    local XSM_MIN = 0
    local XSM_MAX = 4
    local SM_MIN = 5
    local SM_MAX = 6
    local MED_MIN = 7
    local MED_MAX = 11
    local LG_MIN = 12
    local LG_MAX = 13
    local XLG_MIN = 14
    local XLG_MAX = 16
    if numberOfPlayers >= XSM_MIN and numberOfPlayers <= XSM_MAX then
        say_all("New Raid Size: Xtra Small")
        NUMBER_OF_ALLOWED_TANKS = 1
        NUMBER_OF_ALLOWED_HEALERS = 1
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 1.0
    elseif numberOfPlayers >= SM_MIN and numberOfPlayers <= SM_MAX then
        say_all("New Raid Size: Small")
        NUMBER_OF_ALLOWED_TANKS = 1
        NUMBER_OF_ALLOWED_HEALERS = 1
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 1.5
    elseif numberOfPlayers >= MED_MIN and numberOfPlayers <= MED_MAX then
        say_all("New Raid Size: Medium")
        NUMBER_OF_ALLOWED_TANKS = 1
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 3.0
    elseif numberOfPlayers >= LG_MIN and numberOfPlayers <= LG_MAX then
        say_all("New Raid Size: Large")
        NUMBER_OF_ALLOWED_TANKS = 2
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 5.0
    elseif numberOfPlayers >= XLG_MIN and numberOfPlayers <= XLG_MAX then
        say_all("New Raid Size: Xtra Large")
        NUMBER_OF_ALLOWED_TANKS = 2
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 2
        BOSS_MULTIPLIER = 10.0
    end
end

function numberOfPlayersWithClass(class)
    local numberOfPlayers = 0
    for key,_ in pairs(ACTIVE_PLAYER_LIST) do
        if ACTIVE_PLAYER_LIST[key]:getClass():getClassName() == class then
            numberOfPlayers = numberOfPlayers + 1
        end
    end
    return numberOfPlayers
end
function displayProperClassName(improperClassName)
    if OLD_CLASS_NAME_FACADE[improperClassName] ~= nil then return OLD_CLASS_NAME_FACADE[improperClassName] end
    return improperClassName
end

function parseProperClassName(properClassName)
    if NEW_CLASS_NAME_FACADE[properClassName] ~= nil then return NEW_CLASS_NAME_FACADE[properClassName] end
    return properClassName
end
HEALER_COOLDOWN_IN_SECONDS = 75

HealerSchema=ClassSchema:new():instantiate("healer", HEALER_COOLDOWN_IN_SECONDS * 30)

function HealerSchema.ultimate(self, playerIndex)
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




GUNSLINGER_COOLDOWN_IN_SECONDS = 120

GunslingerSchema = ClassSchema:new():instantiate("gunslinger", GUNSLINGER_COOLDOWN_IN_SECONDS * 30)

function GunslingerSchema.ultimate(self, playerIndex)
    say(playerIndex, "Engaging active camoflage!")
    execute_command('camo ' .. playerIndex .. " " .. 30)
    self:startCoolDown(playerIndex)
end
DPS_COOLDOWN_IN_SECONDS = 70

DpsSchema = ClassSchema:new():instantiate("dps", DPS_COOLDOWN_IN_SECONDS * 30)


function DpsSchema.ultimate(self, playerIndex)
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

BANDOLIER_COOLDOWN_IN_SECONDS = 75

BandolierSchema=ClassSchema:new():instantiate("bandolier", BANDOLIER_COOLDOWN_IN_SECONDS * 30)

function BandolierSchema.ultimate(self, playerIndex)
    say(playerIndex, "Giving all nearby players ammo!")
    for i=0, 16 do
        if player_present(i) 
        and ACTIVE_BOSSES[i] == nil 
        and GetPlayerDistance(playerIndex, i) <= 5
        or i == playerIndex then
            local currentPlayer = ACTIVE_PLAYER_LIST[get_var(i, "$hash")]
            currentPlayer:getPrimaryWeapon():setAmmo(i, 4)
            currentPlayer:getSecondaryWeapon():setAmmo(i, 3)
        end
    end
    self:startCoolDown(playerIndex)
end
NEW_CLASS_NAME_FACADE = {
    soldier="dps",
    valiant="gunslinger",
    spartan="tank",
    medic="healer",
}

OLD_CLASS_NAME_FACADE = {
    dps="soldier",
    gunslinger="valiant",
    tank="spartan",
    healer="medic"
}


TANK_COOLDOWN_IN_SECONDS = 100

TankSchema=ClassSchema:new():instantiate("tank", TANK_COOLDOWN_IN_SECONDS * 30)

function TankSchema.ultimate(self, playerIndex)
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



CLASS_LIST = {
    ["dps"] = DpsSchema,
    ["healer"] = HealerSchema,
    ["tank"] = TankSchema,
    ["boss"] = BossSchema,
    ["gunslinger"] = GunslingerSchema,
    ["bandolier"] = BandolierSchema
}

function changePlayerClass(playerIndex, newClass)
    if CLASS_LIST[newClass] ~= nil then
        if newClass == "tank" and numberOfPlayersWithClass("tank") >= NUMBER_OF_ALLOWED_TANKS then
            say(playerIndex, "Request DENIED. There are too many spartans already!")
        elseif newClass=="healer" and numberOfPlayersWithClass("healer") >= NUMBER_OF_ALLOWED_HEALERS then
            say(playerIndex, "Request DENIED. There are too many medics already!")
        elseif newClass=="bandolier" and numberOfPlayersWithClass("bandolier") >= NUMBER_OF_ALLOWED_BANDOLIERS then
            say(playerIndex, "Request DENIED. There are too many bandoliers already!")
        else
            say(playerIndex, "Request GRANTED. Changing class to " .. displayProperClassName(newClass) .. "!")
            local currentPlayer = ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]
            currentPlayer:setClass(CLASS_LIST[newClass]:new())
            currentPlayer:setPreferredClass(newClass)
            WritePlayerToFile(get_var(playerIndex, "$hash"))
            if player_alive(playerIndex) then kill(playerIndex) end
        end
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
        local currentBossMaxHealth = currentBoss:getArmor():getMaxHealth()
        local currentBossHealth = 0
        if currentBossInMemory ~= 0 then
            currentBossHealth = read_float(currentBossInMemory + 0xE0)*currentBoss:getArmor():getMaxHealth()
        end
        local chosenColor = pickColor(currentBossHealth, currentBossMaxHealth)
        if player_alive(key) then
            for i=1,16 do
                if get_var(0, "$ticks")%5 == 1 then
                    if player_present(i) then
                        ClearConsole(i)
                        rprint(i, "|c"..string.upper(currentBoss:getArmor():getName(), "$name").."'S HEALTH " .. math.floor(currentBossHealth) .. "/" .. currentBossMaxHealth ..chosenColor)
                        rprint(i, "|c<"..PrintHealthBar(currentBossHealth, currentBossMaxHealth)..">"..chosenColor)
                    end
                end
            end
        else
        end
    end
end




function parseCommand(playerIndex, command)
    if player_present(playerIndex) and player_alive(playerIndex) then
        args = {} 
        local hash = get_var(playerIndex, "$hash")
        local player = ACTIVE_PLAYER_LIST[hash]
        for w in command:lower():gmatch("%w+") do 
            args[#args+1] = w 
        end
        if args[1] == "class" then 
            if #ACTIVE_BOSSES == 0 then
                if args[2] == "boss" and tonumber(get_var(playerIndex, "$lvl")) ~= 4 then
                    say(playerIndex, "You must be an admin to become a boss!")
                else
                    changePlayerClass(playerIndex, parseProperClassName(args[2]))
                end
            else
                say(playerIndex, "You cannot change your class during a boss event!")
            end
            return true
        elseif args[1] == "ult" or args[1] == "ultimate" then
            if player:getClass().boss == nil then
                activateUltimateAbility(hash, playerIndex)
            else
                say(playerIndex, "Bosses cannot do that!")
            end
            return true
        elseif args[1] == "equip" then
            if args[2] ~= nil then
                player:setEquipment(args[2]) 
            else
                say(playerIndex, "You need to specify the equipment you want to equip!")
            end
            return true
        elseif args[1] == "loadout" then
           if player:setLoadout(nil, args[2], args[3]) then
                kill(playerIndex)
           end
           return true
        elseif args[1] == "sp" then
            say_all("Spawning sound!")
            local weap = spawn_object("weap", "zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer", 102.23, 417.59, 5)
            assign_weapon(weap, tonumber(playerIndex))
            return true
        elseif args[1] == "test" then
            rewardLoot('gordius')
            return true
        elseif args[1] == "boss" then
            if tonumber(get_var(playerIndex, "$lvl")) == 4 and player:getClass():getClassName() == "boss" then
                changeBoss(playerIndex, player, args[2])
            else
                say(playerIndex, "You cannot do that!")
            end
            return true
        elseif args[1] == "whoami" then
            say(playerIndex, "You are a " .. displayProperClassName(player:getClass():getClassName()))
            return true
        elseif args[1] == "moreinfo" then
            if ITEM_LIST[args[2]] ~= nil then
                say(playerIndex, "=======================================")
                if ITEM_LIST[args[2]].type then say(playerIndex, "Type: " .. ITEM_LIST[args[2]].type) end
                if ITEM_LIST[args[2]].description then say(playerIndex, "Description: " .. ITEM_LIST[args[2]].description) end
                if ITEM_LIST[args[2]].defense then say(playerIndex, "Defense: " .. ITEM_LIST[args[2]].defense) end
                if ITEM_LIST[args[2]].maxHealth then say(playerIndex, "Health: " .. ITEM_LIST[args[2]].maxHealth) end
                say(playerIndex, "=======================================")
            else
                say(playerIndex, "That item does not exist!")
            end
            return true
        --TODO: Index the want and need rolls based on player
        --TODO: Add class checks on roll commands in future
        elseif args[1] == "greed" then
            if GREED_TABLE ~= nil and GREED_TABLE[playerIndex] == nil and NEED_TABLE[playerIndex] == nil then
                math.randomseed(os.time())
                local lootRoll = math.random(100)
                table.insert(GREED_TABLE, {
                    player=playerIndex,
                    roll=lootRoll
                })
                say_all(get_var(playerIndex, "$name") .. " has selected greed, and rolls a " .. lootRoll)
            else
                say(playerIndex, "You can't roll right now!")
            end
            return true
        elseif args[1] == "need" then
            if NEED_TABLE ~= nil and NEED_TABLE[playerIndex] == nil and GREED_TABLE[playerIndex] == nil then
                math.randomseed(os.time())
                local lootRoll = math.random(100)
                table.insert(NEED_TABLE, {
                    player=playerIndex,
                    roll=lootRoll
                })
                say_all(get_var(playerIndex, "$name") .. " has selected need, and rolls a " .. lootRoll)
            else
                say(playerIndex, "You can't roll right now!")
            end
            return true
        end
        return false
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
function changeBoss(playerIndex, player, selectedBoss)
    if BIPED_TAG_LIST[selectedBoss] ~= nil then
        kill(playerIndex)
        local playerClass = player:getClass()
        player:setBoss(selectedBoss)
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
function loadBipeds()
    --Load in Biped Table
    for key,_ in pairs(ITEM_LIST) do
        if ITEM_LIST[key].type == "ARMOR" or ITEM_LIST[key].type == "BOSS" then
            BIPED_TAG_LIST[key] = FindBipedTag(ITEM_LIST[key].ref)
        end
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
function ReadPlayerFromFile(hash, playerIndex)
    local fileName = "raids_data_files/"..hash
    local newPlayer = PlayerSchema:new():loadPlayer()
    newPlayer:setPlayerIndex(playerIndex)
    local file = io.open(fileName, "r")
    if file ~= nil then
        local EOF = false
        while EOF == false do
            local nextLine = file:read("*l")
            if nextLine == "$DPS_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                local a = file:read("*l")
                newPlayer:setLoadout('dps', p, s)
                newPlayer:setArmor('dps', a)
                file:read("*l")
            end
            if nextLine == "$HEALER_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                local a = file:read("*l")
                newPlayer:setLoadout('healer', p, s)
                newPlayer:setArmor('healer', a)
                file:read("*l")
            end
            if nextLine == "$TANK_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                local a = file:read("*l")
                newPlayer:setLoadout('tank', p, s)
                newPlayer:setArmor('tank', a)
                file:read("*l")
            end
            if nextLine == "$GUNSLINGER_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                local a = file:read("*l")
                newPlayer:setLoadout('gunslinger', p, s)
                newPlayer:setArmor('gunslinger', a)
                file:read("*l")
            end
            if nextLine == "$BANDOLIER_LOADOUT_BEGIN" then
                local p = file:read("*l")
                local s = file:read("*l")
                local a = file:read("*l")
                newPlayer:setLoadout('bandolier', p, s)
                newPlayer:setArmor('bandolier', a)
                file:read("*l")
            end
            if nextLine == "$BOSS_LOADOUT_BEGIN" then
                local a = file:read("*l")
                newPlayer:setArmor('boss', a)
                file:read("*l")
            end
            if nextLine == "$EQUIPMENT_BEGIN" then
                local ekey = file:read("*l")
                if ekey ~= "$EQUIPMENT_END" then
                    newPlayer:setEquipment(ekey)
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
                newPlayer:setPreferredClass(file:read("*l"))
                file:read("*l")
            end
            if nextLine=="$EOF" then
                EOF = true
            end
        end
        file:close()
        return newPlayer
    else
        return nil
    end
end

function loadPlayer(playerIndex) 
    local playerClass = 'dps'
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new():loadPlayer()
    print("\n\n=========================================================")
    print(get_var(playerIndex, "$name") .. ' has joined the server!\n')
    newPlayer:setPlayerIndex(playerIndex)
    local playerData = ReadPlayerFromFile(hash, playerIndex)
    if playerData ~= nil then
        print(get_var(playerIndex, "$name") .. " has a file on record!")
        newPlayer = playerData
        playerClass = newPlayer:getPreferredClass()
        newPlayer:setPlayerIndex(playerIndex)
    else
        print(get_var(playerIndex, "$name") .. " is a new player!")
        newPlayer:setUpNewPlayer()
    end
    print("=========================================================\n\n")
    --step two: initalize values, load player
    ACTIVE_PLAYER_LIST[hash] = newPlayer
    if playerClass ~= "dps" and playerClass ~= "gunslinger" then
        playerClass = "dps"
    end
    changePlayerClass(playerIndex, playerClass)
    Balancer()
end


function unloadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    WritePlayerToFile(hash)
    ACTIVE_PLAYER_LIST[hash] = nil
    Balancer()
end

GREED_TABLE = nil
NEED_TABLE = nil

-- NOTE
-- WHEN MODIFYING LOOT TABLE
-- ADD ITEMS TO LOOT TABLE
-- AND PRETTY TABLE!!!

PRETTY_TABLE={
    gordius="Gordius",
    mightofgordius="Might of Gordius",
    shardofgordius="Shard of Gordius"
}

LOOT_TABLE = {
    gordius = {
        'mightofgordius',
        'shardofgordius',
        'mightofgordius',
        'shardofgordius',
        'mightofgordius',
        'shardofgordius',
    }
}

function computeLoot(playerTable)
    local highest = 0
    local highestIndex = 0
    for key,_ in pairs(playerTable) do
        local newHighest = playerTable[key].roll
        if newHighest > highest then
            highest = newHighest
            highestIndex = playerTable[key].player
        end
    end
    return highestIndex
end

function rewardLoot(props)
    local bossName = props.BOSS
    print("Rewarding loot!")
    print(bossName)
    if LOOT_TABLE[bossName] == nil then return end
    print("Dropping loot for " .. bossName)
    math.randomseed(os.time())
    local number = math.random(6)
    local item = LOOT_TABLE[bossName][number]
    if item == nil then return end
    --queue up roll event
    GREED_TABLE = {}
    NEED_TABLE = {}
    rollEvent = EventItem:new()
    say_all("Boss " .. PRETTY_TABLE[bossName] .. " drops loot " .. PRETTY_TABLE[item])
    say_all("Roll /greed or /need to receive this item.")
    rollEvent:set({
        winningItem=item
    }, nil, function(props) 
        local winningItem = props.winningItem
        local winner = 1
        if #NEED_TABLE > 0 then
            winner = computeLoot(NEED_TABLE)
        elseif #GREED_TABLE > 0 then
            winner = computeLoot(GREED_TABLE)
        else
            say_all("No one rolled on item, so it is destroyed!")
            return
        end
        if player_present(winner) then
            say_all(get_var(winner, "$name") .. " wins item " .. PRETTY_TABLE[winningItem])
            local hash = get_var(winner, "$hash")
            ACTIVE_PLAYER_LIST[hash]:addItemToInventory(winningItem)
        else
            say_all("The player who won is no longer present, so the item is destroyed!")
        end
    end, 30 * 15)
    EventTable:addEvent('gordius_drop_1', rollEvent)
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
    for i=0,16 do
        if player_present(i) then
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
    -- for i=0,16 do
    --     if player_present(i) then
    --         WritePlayerToFile(get_var(i, "$hash"))
    --     end
    -- end
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
        local playerClass = ACTIVE_PLAYER_LIST[hash]
        if playerClass:getClass():getClassName() == "boss" or ACTIVE_BOSSES[playerIndex] ~= nil then
            local bossName = playerClass:getArmor():getName()
            local lootEvent = EventItem:new()
            lootEvent:set({BOSS=bossName}, nil, rewardLoot, 30 * 10)
            EventTable:addEvent(bossName, lootEvent)
            ACTIVE_BOSSES[playerIndex] = nil
            playerClass:setArmor(nil, "DEFAULT")
        end
    end
end

function handleDamage(damagedPlayerIndex, attackingPlayerIndex, damageTagId, Damage, CollisionMaterial, Backtap)
    --TODO: Refactor this into a damage function, that funnels through all players and handles damage accordingly. 
    local attackingPlayer = ACTIVE_PLAYER_LIST[get_var(attackingPlayerIndex, "$hash")]
    local damagedPlayer = ACTIVE_PLAYER_LIST[get_var(damagedPlayerIndex, "$hash")]
    if player_present(damagedPlayerIndex) and player_present(attackingPlayerIndex) then
        if attackingPlayer:getClass():getClassName() == "healer" and damagedPlayer:getClass():getClassName() ~= "boss" then
            local damagedPlayerInMemory = get_dynamic_player(damagedPlayerIndex) 
            if damagedPlayerInMemory ~= 0 then
                local maxPlayerHealth = damagedPlayer:getArmor():getMaxHealth()
                local currentPlayerHealth = read_float(damagedPlayerInMemory + 0xE0)*maxPlayerHealth
                local fraction = currentPlayerHealth / maxPlayerHealth
                if fraction <= 1.10 then
                    execute_command("hp " .. damagedPlayerIndex .. " " .. fraction + 0.1)
                end
            end
            return true,0
        else
            local newDamage = Damage
            if attackingPlayer:getEquipment() ~= nil then  
                newDamage = math.max(newDamage, attackingPlayer:getEquipment():computeNewDamage(Damage)) 
            end
            if damagedPlayer:getEquipment() ~= nil then 
                newDamage = math.min(newDamage, damagedPlayer:getEquipment():computeNewDamage(Damage))
            end
            newDamage = newDamage - damagedPlayer:getArmor():getDefense()
            if newDamage <= 0 then newDamage = 1 end
            if damagedPlayerIndex == attackingPlayerIndex then 
                say(damagedPlayerIndex, "You dealt " .. newDamage .. " damage to yourself, you goober!")
            else
                say(damagedPlayerIndex, "You were dealt " .. newDamage .. " damage!")
                say(attackingPlayerIndex, "You dealt " .. newDamage .. " damage!")
            end
            return true,newDamage
        end
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
        local playerGuard = get_dynamic_player(playerIndex)
        if playerGuard ~= 0 then
            write_float(playerGuard + 0xD8, currentPlayer:getArmor():getMaxHealth())
        end
        return true,BIPED_TAG_LIST[currentPlayer:getArmor():getName()]
    end
end


function handlePrespawn(playerIndex)
    if player_present(playerIndex) then
        local hash = get_var(playerIndex, "$hash")
        if ACTIVE_PLAYER_LIST[hash]:getClass():getClassName() == "boss" then
            execute_command("t ".. tostring(playerIndex) .." ".. tostring(ACTIVE_PLAYER_LIST[hash]:getArmor():getName()))
        end
    end
end

function handleSpawn(playerIndex)
    local hash = get_var(playerIndex, "$hash")
    local currentPlayer = ACTIVE_PLAYER_LIST[hash]
    if currentPlayer:getClass():getClassName() ~= "boss" then
        execute_command('wdel ' .. playerIndex .. ' 5')
    end
    if currentPlayer:getSecondaryWeapon() ~= nil then
        assign_weapon(spawn_object("weap", currentPlayer:getSecondaryWeapon():getRef()), tonumber(playerIndex))
    end
    if currentPlayer:getPrimaryWeapon() ~= nil then
        assign_weapon(spawn_object("weap", currentPlayer:getPrimaryWeapon():getRef()), tonumber(playerIndex))
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