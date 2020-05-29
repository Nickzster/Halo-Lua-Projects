-- BEGIN_IMPORT
-- import Raids.globals.values end
-- END_IMPORT

function savePlayer(hash)
    local currentPlayer = ACTIVE_PLAYER_LIST[hash]
    local fileName = "raids_data_files/"..hash
    if currentPlayer:getClass().boss then
        print("detected a boss player... skipping them!")
    else
        local file = io.open(fileName, "w")
        if file == nil then
            print("ERROR: raids_data_files DOES NOT EXIST. CREATE IT IN ORDER TO SAVE PLAYER DATA!")
        else
            local classNames = {
                dps='DPS',
                healer='HEALER',
                bandolier='BANDOLIER',
                tank='TANK',
                gunslinger='GUNSLINGER'
            }
            for key,_ in pairs(classNames) do
                file:write("$"..classNames[key] .. "_LOADOUT_BEGIN\n")
                if currentPlayer:getPrimaryWeapon(key).getName == nil then
                    file:write(currentPlayer:getPrimaryWeapon(key).."\n")
                else
                    file:write(currentPlayer:getPrimaryWeapon(key):getName().."\n")
                end
                if currentPlayer:getSecondaryWeapon(key).getName == nil then
                    file:write(currentPlayer:getSecondaryWeapon(key).."\n")
                else
                    file:write(currentPlayer:getSecondaryWeapon(key):getName().."\n")
                end
                file:write("$"..classNames[key] .. "_LOADOUT_END\n")
            end
            file:write("$EQUIPMENT_BEGIN\n")
            if currentPlayer:getEquipment() ~= nil then
                file:write(currentPlayer:getEquipment():getName().."\n")
            end
            file:write("$EQUIPMENT_END\n")
            local playerInventory = currentPlayer:getInventory()
            file:write("$INVENTORY_BEGIN\n")
            for key,_ in pairs(playerInventory) do
                file:write(key.."\n")
            end
            file:write("$INVENTORY_END\n")
            file:write("$PREFERRED_CLASS_BEGIN\n")
            file:write(currentPlayer:getPreferredClass()..'\n')
            file:write("$PREFERRED_CLASS_END\n")
            file:write("$EOF")
            file:close()
        end
    end
end

function unloadPlayer(playerIndex) 
    local hash = get_var(playerIndex, "$hash")
    savePlayer(hash)
    ACTIVE_PLAYER_LIST[hash] = nil
end
