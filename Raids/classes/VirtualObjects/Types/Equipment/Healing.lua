-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- END_IMPORT

HealingSchema = ItemSchema:new()

function HealingSchema.computeNewDamage(self,baseDamage)
    return baseDamage
end

function HealingSchema.activate(self) end

HealingSchema['equip'] = equip
HealingSchema['getModifier'] = getModifier