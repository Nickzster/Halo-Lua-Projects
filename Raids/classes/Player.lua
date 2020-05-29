-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.Behaviors.functions end
-- END_IMPORT

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