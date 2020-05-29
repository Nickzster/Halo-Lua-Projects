-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.classes.Dps end
-- import Raids.classes.Healer end
-- import Raids.classes.Tank end
-- import Raids.classes.Boss end
-- import Raids.classes.Gunslinger end
-- import Raids.classes.Bandolier end
-- import Raids.globals.RaidItems end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.globals.values end
-- import Raids.sapp.PlayerEvents.UnloadPlayer end
-- END_IMPORT

CLASS_LIST = {
    ["dps"] = DpsSchema,
    ["healer"] = HealerSchema,
    ["tank"] = TankSchema,
    ["boss"] = BossSchema,
    ["gunslinger"] = GunslingerSchema,
    ["bandolier"] = BandolierSchema
}

function changePlayerClass(playerIndex, newClass)
    if CLASS_LIST[newClass] ~= nil or newClass == "boss" then
        local currentPlayer = ACTIVE_PLAYER_LIST[get_var(playerIndex, "$hash")]
        currentPlayer:setClass(CLASS_LIST[newClass]:new())
        if newClass == "boss" then
            currentPlayer:setPreferredClass('dps')
        else
            currentPlayer:setPreferredClass(newClass)
            local primaryWeapon = currentPlayer:getPrimaryWeapon(newClass)
            local secondaryWeapon = currentPlayer:getSecondaryWeapon(newClass)
            if primaryWeapon.getName == nil then
                local pkey = primaryWeapon
                primaryWeapon = ItemSchema:new():createItem(
                    pkey,
                    ITEM_LIST[pkey].description, 
                    ITEM_LIST[pkey].type, 
                    ITEM_LIST[pkey].dir, 
                    ITEM_LIST[pkey].modifier
                )
            end
            if secondaryWeapon.getName == nil then
                local skey = secondaryWeapon
                secondaryWeapon = ItemSchema:new():createItem(
                    skey,
                    ITEM_LIST[skey].description, 
                    ITEM_LIST[skey].type, 
                    ITEM_LIST[skey].dir, 
                    ITEM_LIST[skey].modifier
                )
            end
            currentPlayer:setLoadout(newClass, primaryWeapon, secondaryWeapon)
            savePlayer(get_var(playerIndex, "$hash"))
        end
        if player_alive(playerIndex) then kill(playerIndex) end
        return true
    else
        say(playerIndex, "That class does not exist!")
        return false
    end
end
