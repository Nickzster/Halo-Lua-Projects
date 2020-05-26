-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.Behaviors.functions end
-- END_IMPORT

PlayerSchema = {
    playerIndex=nil,
    inventory={}
    weapons={
        primary="",
        secondary=""
    }
    equipment="",
    locations={},
    preferredClass="",
    class=nil
}

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
    if ITEM_LIST[itemName] and ITEM_LIST[itemName]:getClasses() then
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

function PlayerSchema.removeEquipmentFromInventory(self,itemName)
    self.inventory[itemName] = nil
end

function PlayerSchema.addUnlock(self,weaponName)
    if WEAPON_DIR_LIST[weaponName] then
        self.unlocks[weaponName] = weaponName
    end
end

function PlayerSchema.setPlayerIndex(self,playerIndex)
    self.playerIndex = playerIndex
end



PlayerSchema['new'] = new
PlayerSchema['getClass'] = getClass
PlayerSchema['setClass'] = setClass