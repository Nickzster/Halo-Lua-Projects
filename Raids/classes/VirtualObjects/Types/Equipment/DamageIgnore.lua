-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.VirtualObjects.Types.Equipment.Shared end
-- END_IMPORT

DamageIgnoreSchema = ItemSchema:new()

function DamageIgnoreSchema.computeNewDamage(self,baseDamage)
    return baseDamage
end

DamageIgnoreSchema['equip'] = equip
DamageIgnoreSchema['getModifier'] = getModifier