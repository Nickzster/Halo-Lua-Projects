-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.Behaviors.functions end
-- END_IMPORT

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