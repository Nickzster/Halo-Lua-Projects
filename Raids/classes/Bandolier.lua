-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.classes.VirtualObjects.Types.Weapons.BatteryWeapon end
-- import Raids.classes.VirtualObjects.Types.Weapons.AmmoWeapon end
-- import Raids.classes.Class end
-- import Raids.classes.Player end
-- import Raids.globals.values end
-- import Raids.util.GetPlayerDistance end
-- END_IMPORT

BANDOLIER_COOLDOWN_IN_SECONDS = 75

BandolierSchema=ClassSchema:new():instantiate("bandolier", BANDOLIER_COOLDOWN_IN_SECONDS * 30)

function BandolierSchema.ultimate(self, playerIndex)
    say(playerIndex, "Giving all nearby players ammo!")
    for i=0, 16 do
        if player_present(i) 
        and ACTIVE_BOSSES[i] == nil 
        and GetPlayerDistance(playerIndex, i) <= 5
        or i == playerIndex then
            local currentPlayer = ACTIVE_PLAYER_LIST[get_var(i, "$hash")]
            currentPlayer:getPrimaryWeapon():setAmmo(i, 4)
            currentPlayer:getSecondaryWeapon():setAmmo(i, 3)
        end
    end
    self:startCoolDown(playerIndex)
end