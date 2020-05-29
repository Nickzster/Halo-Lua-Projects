-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- END_IMPORT

function modifyDamage(attackingEquipment, damagedEquipment, damage)
    local newDamage = damage
    if attackingEquipment ~= nil and attackingEquipment:getType() == "OUTPUT_DAMAGE" then
        newDamage = newDamage + (newDamage * attackingEquipment:getModifier())
    end
    if damagedEquipment ~= nil then
        if damagedEquipment:getType() == "INPUT_DAMAGE" then
            newDamage = newDamage - (newDamage * damagedEquipment:getModifier())
        elseif damagedEquipment:getType() == "INVINCIBILITY" then
            --TODO: Refactor this properly in future
            newDamage = newDamage - (newDamage * damagedEquipment:getModifier())
        elseif damagedEquipment:getType() == "IGNORE" then
            local random = math.random(1, damagedEquipment:getModifier())
            if random == 1 then newDamage = 0 end
        end
    end
    return newDamage
end