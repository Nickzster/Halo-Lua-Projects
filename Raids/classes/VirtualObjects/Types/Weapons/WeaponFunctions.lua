-- BEGIN_IMPORT
-- import Raids.classes.VirtualObjects.Item end
-- END_IMPORT

createWeapon = function(self, name, desc, ref, classes, maxAmmo, modifier)
    self:createItem(name, desc, ref, classes)
    self.maxAmmo = maxAmmo
    self.modifier = modifier
    return self 
end

getMaxAmmo = function(self)
    return self.maxAmmo
end

getModifier = function(self)
    return self.modifier
end

