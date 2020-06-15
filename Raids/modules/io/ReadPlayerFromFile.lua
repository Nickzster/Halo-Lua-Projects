-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- END_IMPORT

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
        newPlayer:setArmor('boss', 'dpsstd')
        return newPlayer
    else
        return nil
    end
end