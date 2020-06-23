-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.modules.Events.EventItem end
-- import Raids.classes.Behaviors.functions end
-- END_IMPORT

ItemSchema = {
    name=nil,
    description=nil,
    ref=nil,
    classes={}
}

ItemSchema['new'] = new

function ItemSchema.createItem(self, name, description, ref, classes) 
    self.name = name
    self.description = description
    self.ref = ref
    self.classes = classes
    return self
end

function ItemSchema.getName(self)
    return self.name
end

function ItemSchema.getRef(self)
    return self.ref
end

function ItemSchema.getDescription(self)
    return self.description
end

function ItemSchema.isCompatible(self, className)
    if classes == nil or classes ~= nil and self.classes[className] == nil then return false end
    return true
end 
