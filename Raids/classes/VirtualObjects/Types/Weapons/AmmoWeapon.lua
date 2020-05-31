-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.classes.VirtualObjects.Types.Weapons.WeaponFunctions end
-- import Raids.classes.VirtualObjects.Item end
-- END_IMPORT

AmmoWeapon = ItemSchema:new()

AmmoWeapon['createWeapon'] = createWeapon
AmmoWeapon['getMaxAmmo'] = getMaxAmmo
AmmoWeapon['getModifier'] = getModifier

function AmmoWeapon.setAmmo(self, playerIndex, weaponIndex)
    execute_command("ammo " .. playerIndex .. " " .. self:getMaxAmmo() .. " " .. weaponIndex)
end