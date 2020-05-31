-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Types.Equipment.DamageBooster end
-- import Raids.classes.VirtualObjects.Types.Equipment.DamageIgnore end
-- import Raids.classes.VirtualObjects.Types.Equipment.DamageInvPeriod end
-- import Raids.classes.VirtualObjects.Types.Equipment.DamageReduction end
-- import Raids.classes.VirtualObjects.Types.Equipment.Healing end
-- END_IMPORT

function CreateEquipment(equipmentKey)
    if ITEM_LIST[equipmentKey].type == "DAMAGE_BOOST" then
        return DamageBoosterSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_REDUCE" then
        return DamageReductionSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_INVINCIBILITY" then
        return DamageInvPeriodSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    elseif ITEM_LIST[equipmentKey].type == "DAMAGE_IGNORE" then
        return DamageIgnoreSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    elseif ITEM_LIST[equipmentKey].type == "HEAL" then
        return HealingSchema:new():equip(
            equipmentKey,
            ITEM_LIST[equipmentKey].description,
            nil,
            nil,
            ITEM_LIST[equipmentKey].modifier
        )
    end
end