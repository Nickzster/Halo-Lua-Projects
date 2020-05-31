-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Player end
-- END_IMPORT

function WritePlayerToFile(hash)
    local currentPlayer = ACTIVE_PLAYER_LIST[hash]
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
            if key == "boss" then
                file:write("$BOSS_LOADOUT_BEGIN\n")
                file:write(currentPlayer:getArmor(key):getName().."\n")
                file:write("$BOSS_LOADOUT_END\n")
            else
                file:write("$"..classNames[key] .. "_LOADOUT_BEGIN\n")
                file:write(currentPlayer:getPrimaryWeapon(key):getName().."\n")
                file:write(currentPlayer:getSecondaryWeapon(key):getName().."\n")
                file:write(currentPlayer:getArmor(key):getName().."\n") 
                file:write("$"..classNames[key] .. "_LOADOUT_END\n")
            end
        end
        local playerInventory = currentPlayer:getInventory()
        file:write("$INVENTORY_BEGIN\n")
        for key,_ in pairs(playerInventory) do
            file:write(key.."\n")
        end
        file:write("$INVENTORY_END\n")
        file:write("$EQUIPMENT_BEGIN\n")
        if currentPlayer:getEquipment() ~= nil then
            file:write(currentPlayer:getEquipment():getName().."\n")
        end
        file:write("$EQUIPMENT_END\n")
        file:write("$PREFERRED_CLASS_BEGIN\n")
        file:write(currentPlayer:getPreferredClass()..'\n')
        file:write("$PREFERRED_CLASS_END\n")
        file:write("$EOF")
        file:close()
    end
end