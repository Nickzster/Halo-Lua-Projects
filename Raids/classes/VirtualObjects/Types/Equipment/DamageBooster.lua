-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.VirtualObjects.Types.Equipment.Shared end
-- END_IMPORT

DamageBoosterSchema = ItemSchema:new()


function DamageBoosterSchema.computeNewDamage(self,baseDamage)
    return baseDamage * self:getModifier()
end

DamageBoosterSchema['equip'] = equip
DamageBoosterSchema['getModifier'] = getModifier