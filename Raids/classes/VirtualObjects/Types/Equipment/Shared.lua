-- NO_IMPORTS

equip = function(self, name, description, ref, classes, modifier)
    self.name = name
    self.description = description
    self.ref = ref
    self.classes = classes
    self.modifier = modifier
    return self
end

getModifier = function(self)
    return self.modifier
end