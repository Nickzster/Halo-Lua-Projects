-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.VirtualObjects.Types.Equipment.Shared end
-- END_IMPORT

DamageCritStrikeSchema = ItemSchema:new()

function DamageCritStrikeSchema.computeNewDamage(self,baseDamage)
    math.randomseed(os.time())
    local critstrike = math.random(1, self:getRng())
    if critstrike == 1 then return baseDamage * self:getModifier() else return baseDamage end
    return baseDamage
end

DamageCritStrikeSchema['equip'] = equip
DamageCritStrikeSchema['getModifier'] = getModifier
DamageCritStrikeSchema['getRng'] = getRng