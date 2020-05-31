-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.classes.VirtualObjects.Types.Weapons.WeaponFunctions end
-- import Raids.classes.VirtualObjects.Item end
-- END_IMPORT

BatteryWeapon = ItemSchema:new()

BatteryWeapon['createWeapon'] = createWeapon
BatteryWeapon['getMaxAmmo'] = getMaxAmmo
BatteryWeapon['getModifier'] = getModifier

function BatteryWeapon.setAmmo(self, playerIndex, weaponIndex)
    execute_command("battery " .. playerIndex .. " 100 " .. weaponIndex)
end