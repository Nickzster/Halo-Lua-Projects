-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.globals.values end
-- import Raids.modules.Events.EventItem end
-- END_IMPORT

BossHealthValues = {
    ["DEFAULT"] = 1000,
    ["scourge"] = 5000,
    ["torres"] = 1500,
    ["eliminator"] = 2000,
    ["kreyul"] = 1000,
    ["gordius"]=4000
}

BossSchema = {
    name="DEFAULT",
    boss=true,
    maxHealth=100
}

BossSchema['getMaxHealth'] = function(self)
    return self.maxHealth
end

BossSchema['getClassName'] = getClassName
BossSchema['isBoss'] = function(self)
    return self.boss
end
BossSchema['new'] = new
BossSchema['changeBoss'] = function(self, newBiped)
    self.name = newBiped
    self.maxHealth = BossHealthValues[newBiped]
end