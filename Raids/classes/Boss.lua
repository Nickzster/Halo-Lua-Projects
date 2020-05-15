-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.globals.values end
-- import Raids.modules.Events.EventItem end
-- END_IMPORT

BossHealthValues = {
    ["DEFAULT"] = 1000
}

BossSchema = {
    name="DEFAULT",
    boss=true,
    maxHealth=100
}

BossSchema['new'] = new
BossSchema['changeBoss'] = function(self, newBiped)
    self.name = newBiped
    self.maxHealth = BossHealthValues['DEFAULT']
end