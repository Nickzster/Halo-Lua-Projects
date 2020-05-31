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
    loadouts={
        dps = { 
            primary="piercer",
            secondary="reliable",
            armor="dps_std_armor"
        },
        bandolier={
            primary="limitless",
            secondary="accelerator",
            armor="bandolier_std_armor"
        },
        gunslinger={
            primary="irradiator",
            secondary="discordant",
            armor="gunslinger_std_armor"
        },
        healer={
            primary="lightbringer",
            secondary="faithful",
            armor="healer_std_armor"
        },
        tank={
            primary="brassknuckle",
            secondary="rampart",
            armor="tank_std_armor"
        },
        boss={
            armor="DEFAULT"
        }
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
        rampart="rampart",
        dps_std_armor = "dps_std_armor",
        healer_std_armor="healer_std_armor",
        tank_std_armor="tank_std_armor",
        bandolier_std_armor="bandolier_std_armor",
        gunslinger_std_armor="gunslinger_std_armor"
    },
    equipment=nil,
    locations={},
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
        self.loadouts[key].primary = CreateWeapon(p)
        self.loadouts[key].secondary = CreateWeapon(s)
        self.loadouts[key].armor = CreateArmor(a)
    end
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
        if ITEM_LIST[newPrimaryKey].classes[currentClass] == nil and ITEM_LIST[newSecondaryKey].classes[currentClass] == nil then
            say(self:getPlayerIndex(), "You have specified a weapon that is NOT compatible with your class!")
            return false
        end
        self.loadouts[currentClass].primary = CreateWeapon(newPrimaryKey)
        self.loadouts[currentClass].secondary = CreateWeapon(newSecondaryKey)
        return true
    else
        if ITEM_LIST[newPrimary] == nil or ITEM_LIST[newSecondary] == nil then
            say(self:getPlayerIndex(), "You have specified an item that does NOT exist!")
            return false
        end
    end
end

function PlayerSchema.setBoss(self, newBossKey)
    if ITEM_LIST[newBossKey] ~= nil and ITEM_LIST[newBossKey].type == "BOSS" then
        self.loadouts['boss'].armor = CreateArmor(newBossKey)
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
        say(self:getPlayerIndex(), "You have specified an item that does NOT exist!")
        return false
    end
end

function PlayerSchema.getArmor(self, key)
    return self.loadouts[self:getClassNameUtil(key)].armor
end


PlayerSchema['new'] = new