-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.globals.RaidItems end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.sapp.PlayerEvents.Commands.ChangePlayerClass end
-- END_IMPORT


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