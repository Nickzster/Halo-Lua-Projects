-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- END_IMPORT

DamageReductionSchema = ItemSchema:new()

function DamageReductionSchema.computeNewDamage(self,baseDamage)
    return baseDamage - (baseDamage * self:getModifier())
end

DamageReductionSchema['equip'] = equip
DamageReductionSchema['getModifier'] = getModifier