-- NO_IMPORTS

equip = function(self, name, description, ref, classes, modifier, rng)
    self.name = name
    self.description = description
    self.ref = ref
    self.classes = classes
    self.modifier = modifier
    self.rng = rng
    return self
end

getModifier = function(self)
    return self.modifier
end

getRng = function(self)
    return self.rng
end