-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.VirtualObjects.Types.Equipment.Shared end
-- END_IMPORT

DamageIgnoreSchema = ItemSchema:new()

function DamageIgnoreSchema.computeNewDamage(self,baseDamage)
    math.randomseed(os.time())
    local ignore = math.random(1, self:getRng())
    if ignore == 1 then return 0 else return baseDamage end
end

DamageIgnoreSchema['equip'] = equip
DamageIgnoreSchema['getModifier'] = getModifier
DamageIgnoreSchema['getRng'] = getRng