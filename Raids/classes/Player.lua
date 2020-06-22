-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.VirtualObjects.Types.Weapons.AmmoWeapon end
-- import Raids.classes.VirtualObjects.Types.Weapons.BatteryWeapon end
-- import Raids.classes.VirtualObjects.Types.Armor end
-- import Raids.classes.VirtualObjects.Creational.CreateWeapon end
-- import Raids.classes.VirtualObjects.Creational.CreateArmor end
-- import Raids.classes.VirtualObjects.Creational.CreateEquipment end
-- import Raids.classes.Behaviors.functions end
-- import Raids.classes.Class end
-- import Raids.globals.RaidItems end
-- END_IMPORT

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

function PlayerSchema.WritePlayerToFile(self)
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
                file:write(self:getPrimaryWeapon(key):getName().."\n")
                file:write(self:getSecondaryWeapon(key):getName().."\n")
                file:write(self:getArmor(key):getName().."\n") 
                file:write("$"..classNames[key] .. "_LOADOUT_END\n")
            end
        end
        local playerInventory = self:getInventory()
        file:write("$INVENTORY_BEGIN\n")
        for key,_ in pairs(playerInventory) do
            file:write(key.."\n")
        end
        file:write("$INVENTORY_END\n")
        file:write("$EQUIPMENT_BEGIN\n")
        if self:getEquipment() ~= nil then
            file:write(self:getEquipment():getName().."\n")
        end
        file:write("$EQUIPMENT_END\n")
        file:write("$PREFERRED_CLASS_BEGIN\n")
        file:write(self:getPreferredClass()..'\n')
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