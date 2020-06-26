api_version="1.10.1.0"

LOCATIONS= {
    ["torres_event_1"] = "You approach an important computer!",
    ["standardcrate"] = "You have found a crate!",
    ["heroiccrate"] = "You have found a Heroic crate!",
    ["legendarycrate"] = "You have found a Legendary crate!",
    ["mythiccrate"] = "You have found a Mythic crate!",
    ["eclipsecrate"] = "You have found an Eclipse crate!",
    ["novacrate"] = "You have found a Nova crate!",
    ["forerunnercrate"] = "You have found a Forerunner crate!",
    ["reclaimercrate"] = "You have found a Reclaimer crate!",
    ["inheritorcrate"] = "You have found an Inheritor crate!",
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
-- ARMOR: Different Armors that can be worn.
-- DAMAGE_BOOST: Multiplies the incoming base damage for a weapon by the modifier amount, and adds it to the base damage value.
-- DAMAGE_REDUCE: Multiplies the incoming base damage for a weapon by the modifier amount, and subtracts it from the base damage value.
-- DAMAGE_CRIT_STRIKE: Specifies the upper bounds of the RNG to double the damage.
-- DAMAGE_IGNORE: Specifies the upper bounds of the RNG to ignore damage.
-- BOSS: A boss that the player(s) will encounter!

ITEM_LIST = {}





equip = function(self, name, description, ref, classes, modifier, rng)
    self.name = name
    self.description = description
    self.ref = ref
    self.classes = classes
    self.modifier = modifier
    self.rng = rng
    return self
end

getModifier = function(self)
    return self.modifier
end

getRng = function(self)
    return self.rng
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
AmmoWeapon = ItemSchema:new()

AmmoWeapon['createWeapon'] = createWeapon
AmmoWeapon['getMaxAmmo'] = getMaxAmmo
AmmoWeapon['getModifier'] = getModifier


function AmmoWeapon.setAmmo(self, playerIndex, weaponIndex)
    execute_command("ammo " .. playerIndex .. " " .. self:getMaxAmmo() .. " " .. weaponIndex)
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



function CreateEquipment(equipmentKey)
    if ITEM_LIST[equipmentKey].type == "DAMAGE_BOOST" then
        return DamageBoosterSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier,
            nil
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_REDUCE" then
        return DamageReductionSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier,
            nil
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_CRIT_STRIKE" then
        return DamageCritStrikeSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier,
            ITEM_LIST[equipmentKey].rng
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_IGNORE" then
        return DamageIgnoreSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            nil,
            ITEM_LIST[equipmentKey].rng
        )
    elseif ITEM_LIST[equipmentKey].type == "HEAL" then
        return HealingSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier,
            nil
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
PlayerSchema = {
    playerIndex=nil,
    loadouts=nil,
    inventory=nil,
    equipment=nil,
    locations=nil,
    preferredClass=nil,
    class=nil,
    damage=0
}


function PlayerSchema.setClass(self, class)
    self.class = class
    return self.class
end

function PlayerSchema.create(self, playerIndex)
    local defaultTable = {
        locations = {},
        startingLoadouts = {
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
                secondary="concusser",
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
        },
        startingInventory = {
            piercer="piercer",
            reliable="reliable",
            limitless="limitless",
            accelerator="accelerator",
            irradiator="irradiator",
            concusser="concusser",
            lightbringer="lightbringer",
            faithful="faithful",
            brassknuckle="brassknuckle",
            rampart="rampart",
            dpsstd = "dpsstd",
            healerstd="healerstd",
            tankstd="tankstd",
            bandolierstd="bandolierstd",
            gunslingerstd="gunslingerstd",
            DEFAULT="DEFAULT"
        },
        startingEquipment = nil,
        preferredClass = 'dps'
    }
    local newPlayer = self:ReadPlayerFromFile(get_var(playerIndex, "$hash"), defaultTable)
    -- Instantiate player using table
    self.playerIndex = playerIndex
    self.loadouts = newPlayer['startingLoadouts']
    self.inventory = newPlayer['startingInventory']
    self.locations = newPlayer['locations']
    self:setEquipment(newPlayer['startingEquipment'])
    self.preferredClass = newPlayer['preferredClass']
    self:instantiatePlayer()
    return self
end

function PlayerSchema.instantiatePlayer(self)
    for key,_ in pairs(self.loadouts) do
        local p = self.loadouts[key].primary
        local s = self.loadouts[key].secondary
        local a = self.loadouts[key].armor
        self:setLoadout(key, p, s)
        self:setArmor(key, a)
    end
end

function PlayerSchema.savePlayer(self)
    self:WritePlayerToFile(get_var(self:getPlayerIndex(), "$hash"), self)
end

function PlayerSchema.delete(self)
   self:savePlayer()
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
    if ITEM_LIST[itemName] and self:getItemFromInventory(itemName) == nil then
        self.inventory[itemName] = itemName
        say(self.playerIndex, "New Item: " ..itemName.. " has been added to your inventory!")
        return true
    else
        return false
    end
end

function PlayerSchema.getItemFromInventory(self, item)
    if self.inventory[item] then return self.inventory[item] else return nil end
end

function PlayerSchema.checkForItem(self, item)
    if self.inventory[item] ~= nil then return true else return false end
end

function PlayerSchema.removeItemFromInventory(self,itemName)
    if self:getItemFromInventory(itemName) ~= nil then
        say(self.playerIndex, "Item: ".. itemName .. " has been removed from your inventory!")
        self.inventory[itemName] = nil
        return true
    else
        return false
    end
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
    if newEquipmentKey == nil then return end
    if ITEM_LIST[newEquipmentKey] ~= nil 
    and self:getItemFromInventory(newEquipmentKey) ~= nil
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
        if self:checkForItem(newPrimaryKey) == false or self:checkForItem(newSecondaryKey) == false then
            say(self:getPlayerIndex(), "You do not have these weapons yet!")
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
        if self:checkForItem(newArmorKey) == false then
            say(self:getPlayerIndex(), "You do not have this armor unlocked!")
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

function PlayerSchema.addDamage(self, newDamage)
    self.damage = self.damage + newDamage
end

function PlayerSchema.getDamageDealt(self)
    return self.damage
end

function PlayerSchema.resetDamage(self)
    self.damage = 0
end

function PlayerSchema.buildFileObject(self)
   return {
        dps={
            primary=self:getPrimaryWeapon('dps'):getName(),
            secondary=self:getSecondaryWeapon('dps'):getName(),
            armor=self:getArmor('dps'):getName()
        },
        healer={
            primary=self:getPrimaryWeapon('healer'):getName(),
            secondary=self:getSecondaryWeapon('healer'):getName(),
            armor=self:getArmor('healer'):getName()
        },
        tank={
            primary=self:getPrimaryWeapon('tank'):getName(),
            secondary=self:getSecondaryWeapon('tank'):getName(),
            armor=self:getArmor('tank'):getName()
        },
        gunslinger={
            primary=self:getPrimaryWeapon('gunslinger'):getName(),
            secondary=self:getSecondaryWeapon('gunslinger'):getName(),
            armor=self:getArmor('gunslinger'):getName()
        },
        bandolier={
            primary=self:getPrimaryWeapon('bandolier'):getName(),
            secondary=self:getSecondaryWeapon('bandolier'):getName(),
            armor=self:getArmor('bandolier'):getName()
        },
        inventory=self:getInventory(),
        equipment=self:getEquipment():getName(),
        preferredClass=self:getPreferredClass()
    }
end

function PlayerSchema.WritePlayerToFile(self)
    local fileObject = self:buildFileObject()
    local hash = get_var(self:getPlayerIndex(), "$hash")
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
            if key ~= "boss" then 
                file:write("$"..classNames[key] .. "_LOADOUT_BEGIN\n")
                file:write(fileObject[key]['primary'] .."\n")
                file:write(fileObject[key]['secondary'] .."\n")
                file:write(fileObject[key]['armor'] .."\n") 
                file:write("$"..classNames[key] .. "_LOADOUT_END\n")
            end
        end
        local playerInventory = fileObject['inventory']
        file:write("$INVENTORY_BEGIN\n")
        for key,_ in pairs(playerInventory) do
            file:write(key.."\n")
        end
        file:write("$INVENTORY_END\n")
        file:write("$EQUIPMENT_BEGIN\n")
        local playerEquipment = fileObject['equipment']
        if playerEquipment ~= nil then
            file:write(playerEquipment.."\n")
        end
        file:write("$EQUIPMENT_END\n")
        file:write("$PREFERRED_CLASS_BEGIN\n")
        file:write(fileObject['preferredClass']..'\n')
        file:write("$PREFERRED_CLASS_END\n")
        file:write("$EOF")
        file:close()
    end
end

function PlayerSchema.ReadPlayerFromFile(self, hash, defaultPlayerTable)
    local fileName = "raids_data_files/"..hash
    local file = io.open(fileName, "r")
    local newPlayerTable = defaultPlayerTable
    if file ~= nil then
        local EOF = false
        while EOF == false do
            local nextLine = file:read("*l")
            if nextLine == "$DPS_LOADOUT_BEGIN" then
                newPlayerTable['startingLoadouts']['dps']['primary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['dps']['secondary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['dps']['armor'] = file:read("*l")
                file:read("*l")
            end
            if nextLine == "$HEALER_LOADOUT_BEGIN" then
                newPlayerTable['startingLoadouts']['healer']['primary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['healer']['secondary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['healer']['armor'] = file:read("*l")
                file:read("*l")
            end
            if nextLine == "$TANK_LOADOUT_BEGIN" then
                newPlayerTable['startingLoadouts']['tank']['primary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['tank']['secondary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['tank']['armor'] = file:read("*l")
                file:read("*l")
            end
            if nextLine == "$GUNSLINGER_LOADOUT_BEGIN" then
                newPlayerTable['startingLoadouts']['gunslinger']['primary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['gunslinger']['secondary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['gunslinger']['armor'] = file:read("*l")
                file:read("*l")
            end
            if nextLine == "$BANDOLIER_LOADOUT_BEGIN" then
                newPlayerTable['startingLoadouts']['bandolier']['primary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['bandolier']['secondary'] = file:read("*l")
                newPlayerTable['startingLoadouts']['bandolier']['armor'] = file:read("*l")
                file:read("*l")
            end
            if nextLine == "$EQUIPMENT_BEGIN" then
                local ekey = file:read("*l")
                if ekey ~= "$EQUIPMENT_END" then
                    newPlayerTable['startingEquipment'] = ekey
                    file:read("*l")
                end
            end
            if nextLine=="$INVENTORY_BEGIN" then
                local currentInventoryItem = file:read("*l")
                while currentInventoryItem ~= "$INVENTORY_END" do
                    if newPlayerTable['startingInventory'][currentInventoryItem] == nil then
                        newPlayerTable['startingInventory'][currentInventoryItem] = currentInventoryItem
                    end
                    currentInventoryItem = file:read("*l")
                end
            end
            if nextLine=="$PREFERRED_CLASS_BEGIN" then
                newPlayerTable['preferredClass'] = file:read("*l")
                file:read("*l")
            end
            if nextLine=="$EOF" then
                EOF = true
            end
        end
        file:close()
    end
    return newPlayerTable
end


PlayerSchema['new'] = new
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
DamageCritStrikeSchema = ItemSchema:new()

function DamageCritStrikeSchema.computeNewDamage(self,baseDamage)
    math.randomseed(os.time())
    local critstrike = math.random(1, self:getRng())
    if critstrike == 1 then return baseDamage * self:getModifier() else return baseDamage end
    return baseDamage
end

DamageCritStrikeSchema['equip'] = equip
DamageCritStrikeSchema['getModifier'] = getModifier
DamageCritStrikeSchema['getRng'] = getRng
DamageIgnoreSchema = ItemSchema:new()

function DamageIgnoreSchema.computeNewDamage(self,baseDamage)
    math.randomseed(os.time())
    local ignore = math.random(1, self:getRng())
    if ignore == 1 then return 0 else return baseDamage end
end

DamageIgnoreSchema['equip'] = equip
DamageIgnoreSchema['getModifier'] = getModifier
DamageIgnoreSchema['getRng'] = getRng
DamageBoosterSchema = ItemSchema:new()


function DamageBoosterSchema.computeNewDamage(self,baseDamage)
    return baseDamage * self:getModifier()
end

DamageBoosterSchema['equip'] = equip
DamageBoosterSchema['getModifier'] = getModifier
DamageReductionSchema = ItemSchema:new()

function DamageReductionSchema.computeNewDamage(self,baseDamage)
    return baseDamage / self:getModifier()
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
BOSS_DIALOG = {
    boom={
        spawn={
            ref="vehicles\\warthog\\raids\\torres\\fuckemup",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=10,
            played=false
        },
        health_bracket_98={
            ref="vehicles\\warthog\\raids\\torres\\getem",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=9,
            played=false
        }
    },
    bewm={
        spawn={
            ref="vehicles\\warthog\\raids\\torres\\catchifcan",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=10,
            played=false
        }
    },
    griswald={
        spawn={
            ref="vehicles\\warthog\\raids\\torres\\shame",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=12,
            played=false
        },
        health_bracket_98 = {
            ref="vehicles\\warthog\\raids\\torres\\defected",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=20,
            played=false
        },
        health_bracket_50={
            ref="vehicles\\warthog\\raids\\torres\\reasons",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=16,
            played=false
        }
    },
    backdraft={
        spawn={
            ref="vehicles\\warthog\\raids\\torres\\scared",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=8,
            played=false

        }
    },
    torres={
        spawn={
            ref="vehicles\\warthog\\raids\\torres\\fine",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=8,
            played=false
        },
        savant_inbound={
            ref="vehicles\\warthog\\raids\\torres\\nodice",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=20,
            played=false
        },
        savant_spawn={
            ref="vehicles\\warthog\\raids\\torres\\savantdeployed",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=7,
            played=false
        },
        wipe={
            ref="vehicles\\warthog\\raids\\torres\\wipe",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=60,
            played=false
        },
        health_bracket_98={
            ref="vehicles\\warthog\\raids\\torres\\hits",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=10,
            played=false
        },
        health_bracket_90={
            ref="vehicles\\warthog\\raids\\torres\\lucky",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=9,
            played=false
        },
        health_bracket_75={
            ref="vehicles\\warthog\\raids\\torres\\giveup",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=14,
            played=false
        },
        health_bracket_50={
            ref="vehicles\\warthog\\raids\\torres\\runaway",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=11,
            played=false
        },
        health_bracket_25={
            ref="vehicles\\warthog\\raids\\torres\\howlose",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=9,
            played=false
        },
        death={
            ref="vehicles\\warthog\\raids\\torres\\accomplished",
            loc={
                x=54.33,
                y=3.33,
                z=32.51
            },
            seconds=60,
            played=false
        }
    }
}


BossSchema=ClassSchema:new():instantiate("boss", 0)

function BossSchema.new(self)
    local newInstance = ClassSchema:new():instantiate("boss", 0, 0)
    return new(self, newInstance)
end
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




GUNSLINGER_COOLDOWN_IN_SECONDS = 120

GunslingerSchema = ClassSchema:new():instantiate("gunslinger", GUNSLINGER_COOLDOWN_IN_SECONDS * 30)

function GunslingerSchema.ultimate(self, playerIndex)
    say(playerIndex, "Engaging active camoflage!")
    execute_command('camo ' .. playerIndex .. " " .. 30)
    self:startCoolDown(playerIndex)
end
function playDialog(bossName, variant)
    if BOSS_DIALOG[bossName] == nil 
    or BOSS_DIALOG[bossName][variant] == nil 
    then 
        print("### " .. variant .. " NOT FOUND!") 
        return 
    end
    if BOSS_DIALOG[bossName][variant].played then 
        return 
    end
    local dialogToPlay = BOSS_DIALOG[bossName][variant]
    local tagref = spawn_object("vehi", 
    dialogToPlay.ref,
    dialogToPlay.loc.x,
    dialogToPlay.loc.y,
    dialogToPlay.loc.z)
    local deleteDialog = EventItem:new()
    deleteDialog:set({
        ['deleteDialog'] = tagref
    }, 
    nil,
    function(props) destroy_object(props.deleteDialog) end,
    dialogToPlay.seconds * 30)
    EventTable:addEvent(bossName .. "_" .. variant, deleteDialog)
    BOSS_DIALOG[bossName][variant].played = true
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

function Balancer()
    local numberOfPlayers = 0
    for k,v in pairs(ACTIVE_PLAYER_LIST) do
        numberOfPlayers = numberOfPlayers + 1
    end
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
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 1.5
    elseif numberOfPlayers >= MED_MIN and numberOfPlayers <= MED_MAX then
        say_all("New Raid Size: Medium")
        NUMBER_OF_ALLOWED_TANKS = 1
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 2.5
    elseif numberOfPlayers >= LG_MIN and numberOfPlayers <= LG_MAX then
        say_all("New Raid Size: Large")
        NUMBER_OF_ALLOWED_TANKS = 2
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 3.75
    elseif numberOfPlayers >= XLG_MIN and numberOfPlayers <= XLG_MAX then
        say_all("New Raid Size: Xtra Large")
        NUMBER_OF_ALLOWED_TANKS = 2
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 2
        BOSS_MULTIPLIER = 5.0
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


function displayProperClassName(improperClassName)
    if OLD_CLASS_NAME_FACADE[improperClassName] ~= nil then return OLD_CLASS_NAME_FACADE[improperClassName] end
    return improperClassName
end

function parseProperClassName(properClassName)
    if NEW_CLASS_NAME_FACADE[properClassName] ~= nil then return NEW_CLASS_NAME_FACADE[properClassName] end
    return properClassName
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
function activateUltimateAbility(hash, playerIndex)
    if ACTIVE_PLAYER_LIST[hash]:getClass().cooldown == false then
        ACTIVE_PLAYER_LIST[hash]:getClass():ultimate(playerIndex)
    else
        local remainingTime = EventTable:getEvent(ACTIVE_PLAYER_LIST[hash]:getClass():getClassName()..playerIndex):getRemainingTime()
        say(playerIndex, "You can use your ultimate ability in " .. math.ceil(remainingTime / 30) .. " seconds!")
    end
end
CLASS_LIST = {
    ["dps"] = DpsSchema,
    ["healer"] = HealerSchema,
    ["tank"] = TankSchema,
    ["boss"] = BossSchema,
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
            if player_alive(playerIndex) then kill(playerIndex) end
        end
        return true
    else
        say(playerIndex, "That class does not exist!")
        return false
    end
end

SpecialItems = {
    heroiccratekey={
        pretty="Heroic Key",
        type="KEY",
        description="Opens one Heroic Chest."
    },
    legendarycratekey={
        pretty="Legendary Key",
        type="KEY",
        description="Opens one Legendary Chest."
    },
    mythiccratekey={
        pretty="Mythic Key",
        type="KEY",
        description="Opens one Mythic Chest."
    },
    eclipsecratekey={
        pretty="Eclipse Key",
        type="KEY",
        description="Opens one Eclipse Chest."
    },
    novacratekey={
        pretty="Nova Key",
        type="KEY",
        description="Opens one Nova Chest."
    },
    forerunnercratekey={
        pretty="Forerunner Key",
        type="KEY",
        description="Opens one Forerunner Chest."
    },
    reclaimercratekey={
        pretty="Reclaimer Key",
        type="KEY",
        description="Opens one Reclaimer Chest."
    },
    inheritorcratekey={
        pretty="Inheritor Key",
        type="KEY",
        description="Opens one Inheritor Chest."
    }
}


function unloadPlayer(playerIndex)
    local hash = get_var(playerIndex, "$hash")
    ACTIVE_PLAYER_LIST[hash]:delete() 
    ACTIVE_PLAYER_LIST[hash] = nil
    Balancer()
end

GREED_TABLE = nil
NEED_TABLE = nil

-- NOTE
-- WHEN MODIFYING LOOT TABLE
-- ADD ITEMS TO LOOT TABLE
-- AND PRETTY TABLE!!!

LOOT_TABLES = {
    gordius = {
        numberOfItems=3,
        loot={
            'mightofgordius',
            'shardofgordius',
            'heroiccratekey'
        }
    },
    torres = {
        numberOfItems=4,
        loot={
            'torresshieldgenerator',
            'torresammopouch',
            'widowmaker',
            'heroiccratekey'
        }
    },
    eliminator = {
        numberOfItems=4,
        loot={
            'heroiccratekey',
            'linearity',
            'beamoflight',
            'eliminatorshield',
        }
    }
}



function keyDrop()
    local commonkey = 'heroiccratekey'
    local rarekey = 'legendarycratekey'
    local superrarekey = 'mythiccratekey'
    math.randomseed(os.time())
    local commonroll = math.random(50)
    local rareroll = math.random(100)
    local superrareroll = math.random(200)
    print("\n\n#####################################################")
    print("Common Key Roll: " .. commonroll)
    print("Rare Key Roll: " .. rareroll)
    print("Super Rare Key Roll: " .. superrareroll)
    print("#####################################################\n\n")
    if commonroll == 1 then
        say_all("Everyone has been rewarded with a " .. ITEM_LIST[commonkey].pretty)
        for i in pairs(ACTIVE_PLAYER_LIST) do 
            ACTIVE_PLAYER_LIST[i]:addItemToInventory(commonkey)
        end
    end
    if rareroll == 1 then
        say_all("Everyone has been rewarded with a " .. ITEM_LIST[rarekey].pretty)
        for i in pairs(ACTIVE_PLAYER_LIST) do 
            ACTIVE_PLAYER_LIST[i]:addItemToInventory(rarekey)
        end
    end
    if superrareroll == 1 then
        say_all("Everyone has been rewarded with a " .. ITEM_LIST[superrarekey].pretty)
        for i in pairs(ACTIVE_PLAYER_LIST) do 
            ACTIVE_PLAYER_LIST[i]:addItemToInventory(superrarekey)
        end
    end
end

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
    math.randomseed(os.time())
    local bossName = props.BOSS
    if bossName ~= "DEFAULT" then 
        keyDrop()
    end
    -- cancel loot process if boss does not have item
    if LOOT_TABLES[bossName] == nil then return end
    -- compute loot
    local number = math.random(LOOT_TABLES[bossName]['numberOfItems'])
    local itemKey = LOOT_TABLES[bossName]['loot'][number]
    if itemKey == nil or ITEM_LIST[itemKey] == nil then return end
    local displayName = ITEM_LIST[itemKey].pretty
    -- Debug log
    print("\n\n#####################################################")
    print("Dropping loot for " .. bossName)
    print("The loot event rolls a " .. number)
    print("The " .. displayName .. " is dropped!")
    print("#####################################################\n\n")
    --queue up roll event
    GREED_TABLE = {}
    NEED_TABLE = {}
    rollEvent = EventItem:new()
    say_all("Boss " .. bossName .. " drops loot " .. displayName)
    say_all("Roll /greed or /need to receive this item.")
    rollEvent:set({
        winningItem=itemKey,
        display=displayName
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
            say_all(get_var(winner, "$name") .. " wins item " .. props.display)
            local hash = get_var(winner, "$hash")
            ACTIVE_PLAYER_LIST[hash]:addItemToInventory(winningItem)
        else
            say_all("The player who won is no longer present, so the item is destroyed!")
        end
    end, 30 * 30)
    EventTable:addEvent(bossName.. '_drop_1', rollEvent)
end
function ViewItem(item, playerIndex)
    rprint(playerIndex, "|c --------------------------------------------------------------- |nc00b3ff")
    local type = item['type']
    rprint(playerIndex, "|c Name: " .. item['pretty'] .. "|nc00b3ff" )
    rprint(playerIndex, "|c Type: " .. type .. "|nc00b3ff")
    rprint(playerIndex, "|c Description: " .. item['description'] .. "|nc00b3ff")
    if type == 'WEAPON' then
        rprint(playerIndex, "|c Max Ammo: " .. item['maxAmmo'] .. "|nc00b3ff")
    elseif type=="ARMOR" then
        rprint(playerIndex, "|c Max Health: " .. item['maxHealth'] .. "| Defense: " .. item['defense'] .. "|nc00b3ff")
    elseif type == 'DAMAGE_BOOST' or type == "DAMAGE_REDUCE" then
        rprint(playerIndex, "|c Modifier: x" .. item['modifier'] .. "|nc00b3ff")
    elseif type == "DAMAGE_CRIT_STRIKE" then
        rprint(playerIndex, "|c RNG Value: " .. item['rng'] .. "|nc00b3ff")
        rprint(playerIndex, "|c Damage Modifier: x" .. item['modifier'] .. "|nc00b3ff")
    elseif type == "DAMAGE_IGNORE" then
        rprint(playerIndex, "|c RNG Value: " .. item['rng'] .. "|nc00b3ff")
    elseif type == "BOSS" then
        rprint(playerIndex, "|c Defense: " .. item['defense'] .. " | X Small Raid: " .. item['maxHealth']*1.0 .. "|nc00b3ff")
        rprint(playerIndex, "|c Small Raid: " .. item['maxHealth']*1.5 .. " | Medium Raid: " .. item['maxHealth']*2.5 .. "|nc00b3ff" )
        rprint(playerIndex, "|c Large Raid: " .. item['maxHealth']*3.75 .. " | X Large Raid:  " .. item['maxHealth']*5.0 .. "|nc00b3ff" )
    end
    rprint(playerIndex, "|c --------------------------------------------------------------- |nc00b3ff")
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

function playHealthDialog(health, maxHealth, currentBoss)
    local healthRatio = health / maxHealth
    if player_alive(currentBoss:getPlayerIndex()) then
        if healthRatio <= 0.98 and healthRatio > 0.90 then
            playDialog(currentBoss:getArmor():getName(), 'health_bracket_98')
        elseif healthRatio <= 0.90 and healthRatio > 0.75 then
            playDialog(currentBoss:getArmor():getName(), 'health_bracket_90')
        elseif healthRatio <= 0.75 and healthRatio > 0.50 then
            playDialog(currentBoss:getArmor():getName(), 'health_bracket_75')
        elseif healthRatio <= 0.50 and healthRatio > 0.25 then
            playDialog(currentBoss:getArmor():getName(), 'health_bracket_50')
        elseif healthRatio <= 0.25 then
            playDialog(currentBoss:getArmor():getName(), 'health_bracket_5')
        end
    end
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
        playHealthDialog(currentBossHealth, currentBossMaxHealth, currentBoss)
        if player_alive(key) then
            for i=1,16 do
                if get_var(0, "$ticks")%5 == 1 then
                    if player_present(i) and player_alive(i) then
                        ClearConsole(i)
                        rprint(i, "|c Damage Dealt: " .. tostring(ACTIVE_PLAYER_LIST[get_var(i, "$hash")]:getDamageDealt()) .. "|nc00b3ff")
                        rprint(i, "|c"..string.upper(currentBoss:getArmor():getName(), "$name").."'S HEALTH " .. math.floor(currentBossHealth) .. "/" .. currentBossMaxHealth ..chosenColor)
                        rprint(i, "|c<"..PrintHealthBar(currentBossHealth, currentBossMaxHealth)..">"..chosenColor)
                    end
                end
            end
        else
        end
    end
end


STANDARD_CRATE_LOOTERS = {}


Crates = {
    standardcrate = {
        numberOfItems=4,
        contents={
            'armorpiercing',
            'shieldgenerator',
            'luckybullet',
            'luckytabi'
        }
    },
    heroiccrate = {
        numberOfItems=7,
        contents={
            'dpstierone',
            'tanktierone',
            'healertierone',
            'deathwarrant',
            'charity',
            'widowmaker',
            'lawman'
        }
    },
    legendarycrate = {
        numberOfItems=8,
        contents={
            'dpstiertwo',
            'tanktiertwo',
            'healertiertwo',
            'bandoliertiertwo',
            'chicagotypewriter',
            'kingsglaive',
            'lobber',
            'covert'
        }
    },
    mythiccrate = {
        numberOfItems=3,
        contents={
            'thor',
            'grimreaper',
            'piety'
        }
    },
    eclipsecrate={
        numberOfItems=2,
        contents={
            'linearity',
            'lawman'
        }
    }
}

function handleCrate(player, crateName)
    local contents = Crates[crateName]['contents']
    local numberOfItems = Crates[crateName]['numberOfItems']
    math.randomseed(os.time())
    local number = math.random(numberOfItems)
    local item = contents[number]
    print("\n\n#####################################################")
    print("The loot event rolls a " .. number)
    print("The " .. ITEM_LIST[item].pretty .. " is looted!")
    print("#####################################################\n\n")
    if player_present(player:getPlayerIndex()) then
        say_all(get_var(player:getPlayerIndex(), "$name") .. " just looted a " .. ITEM_LIST[item].pretty)
        player:addItemToInventory(item)
    end
end

function reward(player, crateName)
    if Crates[crateName] ~= nil then
        local keyname = crateName .. "key"
        if crateName == "standardcrate" then
            if STANDARD_CRATE_LOOTERS[get_var(player:getPlayerIndex(), "$hash")] == nil then
                STANDARD_CRATE_LOOTERS[get_var(player:getPlayerIndex(), "$hash")] = true
                handleCrate(player, crateName)
            else
                say(player:getPlayerIndex(), "You have already looted this crate!")
            end
        else
            if player:checkForItem(keyname) then
                handleCrate(player, crateName)
                player:removeItemFromInventory(keyname)
            else
                say(player:getPlayerIndex(), "You need a " .. ITEM_LIST[keyname].pretty .. " to loot this chest!")
            end
        end
    end
end

BossList = {
    scourge={
        pretty="Scourge",
        description="Scourge Boss",
        type="BOSS",
        ref="h2spp\\characters\\flood\\juggernaut\\scourge",
        maxHealth=35000,
        defense=0,
        classes={
            boss=true
        }
    },
    torres={
        pretty="Torres",
        description="Torres Boss",
        type="BOSS",
        ref="rangetest\\cmt\\characters\\evolved_h1-spirit\\cyborg\\bipeds\\torres",
        maxHealth=27500,
        defense=0,
        classes={
            boss=true
        }
    },
    eliminator={
        pretty="Eliminator",
        description="Eliminator Boss",
        type="BOSS",
        ref="rangetest\\cmt\\characters\\spv3\\forerunner\\enforcer\\bipeds\\eliminator",
        maxHealth=21000,
        defense=0,
        classes={
            boss=true
        }
    },
    kreyul={
        pretty="Kreyul",
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
        pretty="Gordius",
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
        pretty="DEFAULT",
        description="Default Map Biped",
        type="ARMOR",
        ref="hcea\\characters\\cyborg\\spartan",
        maxHealth=100,
        defense=0,
        classes={
            boss=true
        }
    },
    backdraft={
        pretty="Backdraft",
        description="Backdraft Boss",
        type="BOSS",
        ref="bourrin\\halo reach\\spartan\\male\\backdraft",
        maxHealth=12000,
        defense=0,
        classes={
            boss=true
        }
    },
    boom={
        pretty="Boom",
        description="Boom Boss",
        type="BOSS",
        ref="bourrin\\halo reach\\spartan\\male\\boom",
        maxHealth=7500,
        defense=0,
        classes={
            boss=true
        }
    },
    bewm={
        pretty="Bewm",
        description="Bewm Boss",
        type="BOSS",
        ref="bourrin\\halo reach\\spartan\\male\\buum",
        maxHealth=8000,
        defense=0,
        classes={
            boss=true
        }
    },
    griswald={
        pretty="Griswald",
        description="Griswald Boss",
        type="BOSS",
        ref="bourrin\\halo reach\\spartan\\male\\griswald",
        maxHealth=9000,
        defense=0,
        classes={
            boss=true
        }
    },
}

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
SavantEventCompleted = function(props) 
    say_all("Savant Deployed! We dropped it on the roof with the computer!")
    playDialog("torres","savant_spawn")
    spawn_object("weap", "bourrin\\halo3\\weapons\\spartan_laser\\savant", -18.52,-27.71,10)
end

LocationEventCompleted = function(props) 
    say_all("Message Received. Savant Drop is on it's way!")
    savantEventComplete = EventItem:new()
    savantEventComplete:set({}, nil, SavantEventCompleted, 30 * 120)
    EventTable:addEvent('savantEventComplete', savantEventComplete)
end

NotifyPlayersCompleted = function(props) 
    say_all("Be on the look out for a special computer!")
    playDialog("torres","savant_inbound")
    locationEventComplete = EventItem:new()
    locationEventComplete:set({}, function(props, time)
        for i=1,16 do
            if player_present(i) and player_alive(i) then
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


EquipmentList = {
    armorpiercing={
        pretty="Armor Piercing 1",
        description="Increases your damage output!",
        type="DAMAGE_BOOST",
        modifier=1.4
    },
    shieldgenerator={
        pretty="Shield Generator 1",
        description="Decrases the amount of damage you take!",
        type="DAMAGE_REDUCE",
        modifier=1.4
    },
    luckybullet={
        pretty="Lucky Bullet 1",
        description="Has a chance to increase your damage significantly!",
        type="DAMAGE_CRIT_STRIKE",
        rng=20,
        modifier=3
    },
    luckytabi={
        pretty="Lucky Tabi 1",
        description="Has a chance to completely ignore damage!",
        type="DAMAGE_IGNORE",
        rng=20
    },
    godlytabi={
        pretty="Godly Tabi",
        description="If you wear this, you're practically invincible!",
        type="DAMAGE_IGNORE",
        rng=2
    },
    godlybullet={
        pretty="Godly Bullet",
        description="If you wear this, you're doing the reaper's work for him!",
        type="DAMAGE_CRIT_STRIKE",
        rng=2,
        modifier=10
    },
    mightofgordius = {
        pretty="Might of Gordius",
        description="The Might of Gordius increases your damage!",
        type="DAMAGE_BOOST",
        modifier=1.5
    },
    shardofgordius = {
        pretty="Shard of Gordius",
        description="The Shard of Gordius protects you from damage!",
        type="DAMAGE_REDUCE",
        modifier=1.5
    },
    torresshieldgenerator={
        pretty="Torres's Shield Generator",
        description="Torres's Shield Generator protects you from damage!",
        type="DAMAGE_REDUCE",
        modifier=1.5
    },
    torresammopouch={
        pretty="Torres's Ammo Pouch",
        description="Torres's Ammo Pouch boosts your damage!",
        type="DAMAGE_BOOST",
        modifier=1.5
    },
    eliminatorshield={
        pretty = "The Eliminator's Shield",
        description="The Eliminator's Shield graces you with protection.",
        type="DAMAGE_IGNORE",
        rng=5
    },
    beamoflight={
        pretty="The Beam of Light",
        description="The Beam of Light boosts your damage!",
        type="DAMAGE_BOOST",
        modifier=2.0
    }
}
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
            if player:getClass():getClassName() ~= "boss" then
                activateUltimateAbility(hash, playerIndex)
            else
                say(playerIndex, "Bosses cannot do that!")
            end
            return true
        elseif args[1] == "save" then
            player:savePlayer()
            return true
        elseif args[1] == "equip" then
            if args[2] ~= nil then
                player:setEquipment(args[2]) 
            else
                say(playerIndex, "You need to specify the equipment you want to equip!")
            end
            return true
        elseif args[1] == "equipment" then
            say(playerIndex, player:getEquipment():getName())
            return true
        elseif args[1] == "armor" then
            if #ACTIVE_BOSSES == 0 then
                if player:setArmor(nil, args[2]) then
                    kill(playerIndex)
                end
            else
                say(playerIndex, "You cannot change your armor during a boss event!")
            end
            return true
        elseif args[1] == "reward" then
            if tonumber(get_var(playerIndex, "$lvl")) ~= 4 then say("You need admin priviledges to execute this!") return true end
            if args[2] == nil then say(playerIndex, "You need to specify a player index!") return true end
            if args[3] == nil then say(playerIndex, "You need to specify a reward item!") return true end
            if ITEM_LIST[args[3]] == nil then say(playerIndex, "You need to specify a valid item!") return true end
            if player_present(tonumber(args[2])) == false then say(playerIndex, "You need to specify a present player!") return true end
            local targetPlayerHash = get_var(tonumber(args[2]), "$hash")
            ACTIVE_PLAYER_LIST[targetPlayerHash]:addItemToInventory(args[3])
            return true
        elseif args[1] == "remove" then
            if tonumber(get_var(playerIndex, "$lvl")) ~= 4 then say("You need admin priviledges to execute this!") return true end
            if args[2] == nil then say(playerIndex, "You need to specify a player index!") return true end
            if args[3] == nil then say(playerIndex, "You need to speicify an item to remove!") return true end
            if player_present(tonumber(args[2])) == false then say(playerIndex, "You need to specify a present player!") return true end
            local targetPlayerHash = get_var(tonumber(args[2]), "$hash")
            ACTIVE_PLAYER_LIST[targetPlayerHash]:removeItemFromInventory(args[3])
            return true
        elseif args[1] == "respawn" then
            if #ACTIVE_BOSSES == 0 then
                kill(playerIndex)
            else
                say(playerIndex, "You cannot respawn during a boss event!")
            end
            return true
        elseif args[1] == "loadout" then
            if #ACTIVE_BOSSES == 0 then
                if player:setLoadout(nil, args[2], args[3]) then
                        kill(playerIndex)
                end
            else 
                say(playerIndex, "You cannot change your loadout during a boss event!")
            end
           return true
        elseif args[1] == "test" then
            -- Note: get_dynamic_player(playerIndex) is equivalent to m_player or m_object or m_unit
            local playerCurrentWeap = read_word(get_dynamic_player(playerIndex) + 0x2F2)
            if playerCurrentWeap == nil or playerCurrentWeap == 0 then
                say(playerIndex, "Operation failed!")
            else
                say(playerIndex, "The value is: " .. playerCurrentWeap)
            end
            return true
        elseif args[1] == "spawn" then
            local weapon = args[2]
            if tonumber(get_var(playerIndex, "$lvl")) ~= 4 then
                say(playerIndex, "You must be an admin to execute this command!")
            elseif weapon == nil 
            or ITEM_LIST[weapon] == nil
            or ITEM_LIST[weapon].type ~= "WEAPON" 
            or ITEM_LIST[weapon].ref == nil 
            then 
                say(playerIndex, "This item does not exist") 
            else 
                spawn_object("weap", ITEM_LIST[weapon].ref, 105.62, 342.36, -3)
            end
            return true
        elseif args[1] == "boss" then
            if tonumber(get_var(playerIndex, "$lvl")) == 4 and player:getClass():getClassName() == "boss" then
                changeBoss(playerIndex, player, args[2])
            else
                say(playerIndex, "You cannot do that!")
            end
            return true
        elseif args[1] == "wipe" then
            if player:getClass():getClassName() ~= "boss" then say(playerIndex, "You cannot execute this command!") return true end
            local boss = player:getArmor(nil):getName()
            player:setArmor(nil, "DEFAULT")
            for i=0,16 do
                if player_present(i) then
                    kill(i)
                end
            end
            kill(playerIndex)
            playDialog(boss, "wipe")
            return true
        elseif args[1] == "whoami" then
            say(playerIndex, "You are a " .. displayProperClassName(player:getClass():getClassName()))
            return true
        elseif args[1] == "moreinfo" or args[1] == "more" then
            if ITEM_LIST[args[2]] ~= nil then
                ViewItem(ITEM_LIST[args[2]], playerIndex)
            else
                say(playerIndex, "That item does not exist!")
            end
            return true
        elseif args[1] == "own" then
            if ITEM_LIST[args[2]] == nil then say(playerIndex, "This is not a valid item!") return true end
            if player:checkForItem(args[2]) then say(playerIndex, "You have item: " .. ITEM_LIST[args[2]].pretty)
            else say(playerIndex, "You do not have item: " .. ITEM_LIST[args[2]].pretty)
            end   
            return true
        elseif args[1] == "greed" then
            --TODO: Index the want and need rolls based on player
            --TODO: Add class checks on roll commands in future
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

function loadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    local newPlayer = PlayerSchema:new():create(playerIndex)
    local playerClass = newPlayer:getPreferredClass()
    --step two: initalize values, load player
    ACTIVE_PLAYER_LIST[hash] = newPlayer
    if playerClass ~= "dps" then playerClass = "dps" end
    changePlayerClass(playerIndex, playerClass)
    Balancer()
end
ArmorList = {
    dpsstd={
        pretty="DPS T0",
        description="Standard ODST Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\soldier",
        maxHealth=100,
        defense=0,
        classes={
            dps=true
        }
    },
    dpstierone={
        pretty="DPS T1",
        description="Tier 1 Soldier Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\soldier1",
        maxHealth=115,
        defense=0,
        classes={
            dps=true
        }
    },
    dpstiertwo={
        pretty="DPS T2",
        description="Tier 2 Soldier Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\soldier2",
        maxHealth=130,
        defense=0,
        classes={
            dps=true
        }
    },
    healerstd={
        pretty="Healer T0",
        description="Standard ODST armor for medics.",
        type="ARMOR",
        ref="characters\\cyborg_mp\\medic",
        maxHealth=100,
        defense=0,
        classes={
            healer=true
        }
    },
    healertierone={
        pretty="Healer T1",
        description="Tier 1 Medic Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\medic1",
        maxHealth=115,
        defense=0,
        classes={
            healer=true
        }
    },
    healertiertwo={
        pretty="Healer T2",
        description="Tier 2 Medic Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\medic2",
        maxHealth=130,
        defense=0,
        classes={
            healer=true
        }
    },
    tankstd={
        pretty="Tank T0",
        description="Standard MK 6 armor for tanks",
        type="ARMOR",
        ref="hcea\\characters\\cyborg\\spartan",
        maxHealth=500,
        defense=0,
        classes={
            tank=true
        }
    },
    tanktierone={
        pretty="Tank T1",
        description="Tier 1 Spartan Armor",
        type="ARMOR",
        ref="zteam\\objects\\characters\\spartan\\h3\\spartan1",
        maxHealth=550,
        defense=0,
        classes={
            tank=true
        }
    },
    tanktiertwo={
        pretty="Tank T2",
        description="Tier 2 Spartan Armor",
        type="ARMOR",
        ref="zteam\\objects\\characters\\spartan\\h3\\spartan2",
        maxHealth=600,
        defense=0,
        classes={
            tank=true
        }
    },
    bandolierstd={
        pretty="Bandolier T1",
        description="Standard Marine armor for Bandoliers",
        type="ARMOR",
        ref="bourrin\\halo reach\\marine-to-spartan\\bandolier",
        maxHealth=115,
        defense=0,
        classes={
            bandolier=true
        }
    },
    bandoliertiertwo={
        pretty="Bandolier T2",
        description="Tier 2 Bandolier Armor",
        type="ARMOR",
        ref="bourrin\\halo reach\\marine-to-spartan\\bandolier2",
        maxHealth=130,
        defense=0,
        classes={
            bandolier=true
        }
    },
    gunslingerstd={
        pretty="Gunslinger T0",
        description="Standard Elite armor for Gunslingers",
        type="ARMOR",
        ref="np\\objects\\characters\\elite\\h3\\bipeds\\valiant",
        maxHealth=100,
        defense=0,
        classes={
            gunslinger=true
        }
    },
    gunslingertierone={
        pretty="Gunslinger T1",
        description="Tier 1 Valiant Armor",
        type="ARMOR",
        ref="np\\objects\\characters\\elite\\hm\\bipeds\\valiant1",
        maxHealth=115,
        defense=0,
        classes={
            gunslinger=true
        }
    },
    gunslingertiertwo={
        pretty="Gunslinger T2",
        description="Tier 2 Valiant Armor",
        type="ARMOR",
        ref="np\\objects\\characters\\elite\\hm\\bipeds\\valiant2",
        maxHealth=130,
        defense=0,
        classes={
            gunslinger=true
        }
    },
}

WeaponList = {
    piercer={
        pretty="Piercer (BR)",
        description="Battle Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
        maxAmmo=684,
        classes={
            dps=true
        }
    },
    reliable={
        pretty="Reliable (AR)",
        description="Assault Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable",
        maxAmmo=676,
        classes={
            dps=true
        }
    },
    accelerator={
        pretty="Accelerator (MA5K)",
        description="MA5K",
        type="WEAPON",
        ref="altis\\weapons\\br\\accelerator",
        maxAmmo=676,
        classes={
            bandolier=true
        }
    },
    limitless={
        pretty="Limitless (MG)",
        description="MG",
        type="WEAPON",
        ref="rangetest\\cmt\\weapons\\spv3\\human\\turret\\limitless",
        maxAmmo=600,
        classes={
            bandolier=true
        }
    },
    lobber={
        pretty="Lobber (GL)",
        description="Grenade Launcher",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\grenade_launcher\\hr\\lobber",
        maxAmmo=40,
        classes={
            bandolier=true
        }
    },
    lawman={
        pretty="Lawman (DMR)",
        description="DMR",
        type="WEAPON",
        ref="bourrin\\weapons\\dmr\\lawman",
        maxAmmo=500,
        classes={
            bandolier=true
        }
    },
    irradiator={
        pretty="Irradiator (Carbine)",
        description="Carbine",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\covenant_carbine\\h3\\irradiator",
        maxAmmo=636,
        classes={
            gunslinger=true
        }
    },
    brassknuckle={
        pretty="Brass Knuckle (Mauler)",
        description="Mauler",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\mauler\\h3\\brassknuckle",
        maxAmmo=505,
        classes={
            tank=true
        }
    },
    rampart={
        pretty="Rampart (Spiker)",
        description="Spiker",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\spike_rifle\\h3\\rampart",
        maxAmmo=1000,
        classes={
            tank=true
        }
    },
    faithful={
        pretty = "Faithful (PP)",
        description="Plasma Pistol",
        type="WEAPON",
        battery=true,
        ref="h2\\objects\\weapons\\pistol\\plasma_pistol\\faithful",
        maxBattery=100,
        classes={
            healer=true
        }
    },
    lightbringer={
        pretty = "Lightbringer (PR)",
        description="Plasma Rifle",
        type="WEAPON",
        battery=true,
        ref="h2\\objects\\weapons\\rifle\\plasma_rifle\\lightbringer",
        maxBattery=100,
        classes={
            healer=true
        }
    },
    piety={
        pretty = "Piety (BPR)",
        description="Brute Plasma Rifle",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="h2\\objects\\weapons\\rifle\\brute_plasma_rifle\\piety",
        classes={
            healer=true
        }
    },
    linearity={
        pretty="Linearity (Sentinel Beam)",
        description="Sentinel Beam",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="h2\\objects\\weapons\\support_low\\sentinel_beam\\linearity",
        classes={
            healer=true
        }
    },
    eviscerator={
        pretty="Eviscerator (Sword)",
        description="Energy Sword",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="h4\\weapons\\covenant\\energy sword\\eviscerator",
        classes={
            gunslinger=true
        }
    },
    headhunter={
        pretty = "Headhunter (Beam Rifle)",
        description="Beam Rifle",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="zteam\\objects\\weapons\\single\\beam_rifle\\h3\\headhunter",
        classes={
            gunslinger=true
        }
    },
    discordant={
        pretty="Discordant (FRG)",
        description="Fuel Rod Cannon",
        type="WEAPON",
        ref="halo3\\weapons\\'plasma cannon'\\discordant",
        maxAmmo=30,
        classes={
            gunslinger=true
        }
    },
    concusser={
        pretty="Concusser (Concussion Rifle)",
        description="Concussion Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\concussion_rifle\\hr\\concusser",
        maxAmmo=606,
        classes={
            gunslinger=true
        }
    },
    thor={
        pretty="Thor (Gravity Hammer)",
        description="Gravity Hammer",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="zteam\\objects\\weapons\\single\\gravity_hammer\\h3\\thor",
        classes={
            tank=true
        }
    },
    kingsglaive={
        pretty="King's Glaive (Brute Shot)",
        description="Brute Shot",
        type="WEAPON",
        maxAmmo=42,
        ref="zteam\\objects\\weapons\\single\\brute_shot\\h3_6rounds\\kingsglaive",
        classes={
            tank=true
        }
    },
    charity={
        pretty="Charity (Pistol)",
        description="Pistol",
        type="WEAPON",
        maxAmmo=500,
        ref="zteam\\objects\\weapons\\single\\magnum\\h1\\charity",
        classes={
            healer=true
        }
    },
    grimreaper={
        pretty="Grim Reaper (RL)",
        description="Rocket Launcher",
        type="WEAPON",
        maxAmmo=8,
        ref="zteam\\objects\\weapons\\single\\rocket_launcher\\hr\\grimreaper",
        classes={
            dps=true
        }
    },
    deathwarrant={
        pretty ="Death Warrant (SG)",
        description="Shotgun",
        type="WEAPON",
        maxAmmo=60,
        ref="zteam\\objects\\weapons\\single\\shotgun\\h3\\deathwarrant",
        classes={
            tank=true
        }
    },
    chicagotypewriter={
        pretty="Chicago Type Writer (SMG)",
        description="SMG",
        type="WEAPON",
        maxAmmo=400,
        ref="zteam\\objects\\weapons\\single\\smg\\h3\\chicagotypewriter",
        classes={
            healer=true
        }
    },
    widowmaker={
        pretty="Widow Maker (SR)",
        description="Sniper Rifle",
        type="WEAPON",
        maxAmmo=20,
        ref="halo3\\weapons\\sniper rifle\\widowmaker",
        classes={
            dps=true
        }
    },
    covert={
        pretty="Covert (MA5KT)",
        description="Ma5K Tactical Rifle",
        type="WEAPON",
        maxAmmo=250,
        ref="altis\\weapons\\br_spec_ops\\covert",
        classes={
            dps=true
        }
    },
    negotiator={
        pretty="Negotiator (Gauss Rifle)",
        description="Gauss Rifle",
        type="WEAPON",
        maxAmmo=40,
        ref="np\\objects\\weapons\\rifle\\gauss_sniper_rifle\\hm\\negotiator",
        classes={
            dps=true
        }
    },

}


--Callbacks

function buildItemTable()
    for k,v in pairs(ArmorList) do
        ITEM_LIST[k] = v
    end
    for k,v in pairs(BossList) do
        ITEM_LIST[k] = v
    end
    for k,v in pairs(EquipmentList) do
        ITEM_LIST[k] = v
    end
    for k,v in pairs(WeaponList) do
        ITEM_LIST[k] = v
    end
    for k,v in pairs(SpecialItems) do
        ITEM_LIST[k] = v
    end
end

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
    buildItemTable()
    loadBipeds() 
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
    -- BIPED_TAG_LIST = {}
    ACTIVE_PLAYER_LIST = {}
    ACTIVE_BOSSES = {}
    EVENT_TABLE = {}
    ITEM_LIST = {}
end

OnGameStart = OnScriptLoad

OnGameEnd = OnScriptUnload

function handleAreaEnter(playerIndex, areaEntered) 
    if player_present(playerIndex) then
        local hash = get_var(playerIndex, "$hash")
        local player = ACTIVE_PLAYER_LIST[hash]
        if LOCATIONS[areaEntered] ~= nil then say(playerIndex, LOCATIONS[areaEntered])
        end
        player:setLocation(areaEntered)
        reward(player, areaEntered)
    end
end

function handleAreaExit(playerIndex, areaExited) 
    if player_present(playerIndex) then 
        local hash = get_var(playerIndex, "$hash")
        local player = ACTIVE_PLAYER_LIST[hash]
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
            playDialog(bossName, "death")
            for i=0,16 do
                if player_present(i) then
                    ACTIVE_PLAYER_LIST[get_var(i, "$hash")]:resetDamage()
                end
            end
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
                    execute_command("hp " .. damagedPlayerIndex .. " " .. fraction + 0.05)
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
            if damagedPlayer:getClass():getClassName() == "boss" and attackingPlayer:getClass():getClassName() ~= "boss" then
                attackingPlayer:addDamage(newDamage)
            end
            return true,newDamage
        end
    end
    return true
end

function handleTick()
    for i = 0,16 do
        if player_present(i) and player_alive(i) then
            local test = read_bit(get_dynamic_player(i) + 0x208, 4)
            if test ~= nil and test == 1 then
                local activateUltEvent = EventItem:new()
                activateUltEvent:set(
                    {['playerIndex']=i, ['hash']=get_var(i, "$hash")}, 
                    nil, 
                    function(props)  activateUltimateAbility(props.hash, props.playerIndex) end,
                    0
                )
                EventTable:addEvent('PLAYER_' .. i .. '_ULT_ACTIVATE', activateUltEvent)
            end
        end
    end
    PrintBossBar()
    EventTable:cycle()
end

function handleObjectSpawn(playerIndex, tagId, parentObjectId, newObjectId)
    if BIPED_TAG_LIST['DEFAULT'] == nil then 
        loadBipeds() 
    end
    local bossCount = 0
    if player_present(playerIndex) and tagId == BIPED_TAG_LIST['DEFAULT'] then 
        local hash = get_var(playerIndex, "$hash")
        local currentPlayer = ACTIVE_PLAYER_LIST[hash]
        return true,BIPED_TAG_LIST[currentPlayer:getArmor():getName()]
    end
end


function handlePrespawn(playerIndex)
    if player_present(playerIndex) then
        local hash = get_var(playerIndex, "$hash")
        if ACTIVE_PLAYER_LIST[hash]:getClass():getClassName() == "boss" then
            execute_command("t ".. tostring(playerIndex) .." ".. tostring(ACTIVE_PLAYER_LIST[hash]:getArmor():getName()))
            return
        end
        local bossCount = 0
        for k,v in pairs(ACTIVE_BOSSES) do
            bossCount = bossCount + 1 
        end
        if bossCount > 0 then
            execute_command("t " .. tostring(playerIndex) .. " timeout")
        end
    end
end

function handleSpawn(playerIndex)
    local hash = get_var(playerIndex, "$hash")
    local currentPlayer = ACTIVE_PLAYER_LIST[hash]
    local playerGuard = get_dynamic_player(playerIndex)
    if playerGuard ~= 0 then
        write_float(playerGuard + 0xD8, currentPlayer:getArmor():getMaxHealth())
    end
    if currentPlayer:getClass():getClassName() ~= "boss" then
        execute_command('wdel ' .. playerIndex .. ' 5')
    else
        playDialog(currentPlayer:getArmor():getName(), 'spawn')
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