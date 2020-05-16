-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- END_IMPORT

function modifyDamage(attackingPlayer, playerTakingDamage, damage)
    local newDamage = damage
    for inventoryItem,_ in pairs(attackingPlayer) do
        newDamage = newDamage * attackingPlayer[inventoryItem].modifier
    end
    for inventoryItem,_ in pairs(playerTakingDamage) do
        newDamage = newDamage * playerTakingDamage[inventoryItem].modifier
    end
    return newDamage
end