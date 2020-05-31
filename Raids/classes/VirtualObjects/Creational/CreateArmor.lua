-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Types.Armor end
-- END_IMPORT

function CreateArmor(key)
    if ITEM_LIST[key] ~= nil
    and ITEM_LIST[key].type == "ARMOR"
    or ITEM_LIST[key].type == "BOSS"
    then
        return ArmorSchema:new():createArmor(
            key,
            ITEM_LIST[key].description,
            ITEM_LIST[key].ref,
            ITEM_LIST[key].classes,
            ITEM_LIST[key].maxHealth,
            ITEM_LIST[key].defense
        )
    else
        return nil
    end
end