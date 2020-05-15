-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.globals.values end
-- import Raids.modules.Events.EventTable end
-- END_IMPORT

BossSchema = {
    name="DEFAULT",
    boss=true
}

BossSchema['new'] = new
BossSchema['changeBoss'] = function(self, newBiped)
    self.name = newBiped
end