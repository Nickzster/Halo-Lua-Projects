-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.VirtualObjects.Item end
-- import Raids.classes.Behaviors.functions end
-- import Raids.globals.RaidItems end
-- END_IMPORT

ArmorSchema=ItemSchema:new()

function ArmorSchema.createArmor(self, name, desc, ref, classes, maxHealth, defense)
    self:createItem(name, desc, ref, classes)
    if type(maxHealth) == "number" then
        self.maxHealth = maxHealth
    elseif type(maxHealth) == "table" then
        if #ACTIVE_PLAYER_LIST >= 1 and #ACTIVE_PLAYER_LIST <=5 then
            self.maxHealth = maxHealth['small']
        elseif #ACTIVE_PLAYER_LIST >= 6 and #ACTIVE_PLAYER_LIST <= 10 then
            self.maxHealth = maxHealth['med']
        else 
            self.maxHealth = maxHealth['large']
        end
    end
    self.defense = defense
    return self
end

function ArmorSchema.setMaxHealth(self, newHealth)
    self.maxHealth = newHealth
end

function ArmorSchema.getDefense(self)
    return self.defense
end

function ArmorSchema.getMaxHealth(self)
    return self.maxHealth
end


