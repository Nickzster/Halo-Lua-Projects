-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.VirtualObjects.Types.Equipment.Shared end
-- END_IMPORT

DamageInvPeriod = ItemSchema:new()

function DamageInvPeriod.computeNewDamage(self,baseDamage)
    return baseDamage
end

DamageInvPeriod['equip'] = equip
DamageInvPeriod['getModifier'] = getModifier