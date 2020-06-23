-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Types.Equipment.DamageBooster end
-- import Raids.classes.VirtualObjects.Types.Equipment.DamageIgnore end
-- import Raids.classes.VirtualObjects.Types.Equipment.DamageCritStrike end
-- import Raids.classes.VirtualObjects.Types.Equipment.DamageReduction end
-- END_IMPORT

function CreateEquipment(equipmentKey)
    if ITEM_LIST[equipmentKey].type == "DAMAGE_BOOST" then
        return DamageBoosterSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier,
            nil
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_REDUCE" then
        return DamageReductionSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier,
            nil
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_CRIT_STRIKE" then
        return DamageCritStrikeSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier,
            ITEM_LIST[equipmentKey].rng
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_IGNORE" then
        return DamageIgnoreSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            nil,
            ITEM_LIST[equipmentKey].rng
        )
    elseif ITEM_LIST[equipmentKey].type == "HEAL" then
        return HealingSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier,
            nil
        )
    end
end