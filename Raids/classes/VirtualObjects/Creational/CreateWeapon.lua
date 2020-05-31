-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Types.Weapons.AmmoWeapon end
-- import Raids.classes.VirtualObjects.Types.Weapons.BatteryWeapon end
-- END_IMPORT

function CreateWeapon(key)
    if ITEM_LIST[key] ~= nil
    and ITEM_LIST[key].type == "WEAPON" 
    then
        if ITEM_LIST[key].battery ~= nil then
            return BatteryWeapon:new():createWeapon(
                key,
                ITEM_LIST[key].description,
                ITEM_LIST[key].ref,
                ITEM_LIST[key].classes,
                ITEM_LIST[key].maxAmmo,
                ITEM_LIST[key].modifier
            )
        else
            return AmmoWeapon:new():createWeapon(
                key,
                ITEM_LIST[key].description,
                ITEM_LIST[key].ref,
                ITEM_LIST[key].classes,
                ITEM_LIST[key].maxAmmo,
                ITEM_LIST[key].modifier
            )
        end
    else
        return nil
    end
end