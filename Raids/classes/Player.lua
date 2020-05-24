-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.Behaviors.functions end
-- END_IMPORT

PlayerSchema = {
    playerIndex=nil,
    weaponInventory={},
    equipmentInventory={},
    equippedEquipment="",
    equippedPrimary="",
    equippedSecondary="",
    locations={},
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

function PlayerSchema.addInventoryItem(self, itemName)
    if ITEM_LIST[itemName] then
        local newItem = ItemSchema:new()
        newItem:createItem(itemName, ITEM_LIST[itemName].description, ITEM_LIST[itemName].type, ITEM_LIST[itemName].modifier, self.playerIndex)
        self.inventory[itemName] = newItem
    end
end

function PlayerSchema.getPlayerInventory(self)
    return self.inventory
end

function PlayerSchema.removeInventoryItem(self,itemName)
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

--TODO: Future, disallow duplicate redeemUnlocks
function PlayerSchema.redeemUnlock(self, weaponName)
    if self.unlocks[weaponName] then
        local weaponToGive = spawn_object("weapon", WEAPON_DIR_LIST[weaponName])
        assign_weapon(weaponToGive, tonumber(playerIndex))
    end
end

PlayerSchema['new'] = new
PlayerSchema['getClass'] = getClass
PlayerSchema['setClass'] = setClass