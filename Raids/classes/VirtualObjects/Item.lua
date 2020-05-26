-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.modules.Events.EventItem end
-- import Raids.classes.Behaviors.functions end
-- END_IMPORT

ItemSchema = {
    name=nil,
    description=nil,
    type=nil,
    dir=nil
    modifier=nil,
}

ItemSchema['new'] = new

function ItemSchema:destroyItem() end

function ItemSchema.createItem(self, name, description, type, dir, modifier) 
    self.name = name
    self.description = description
    self.type = type
    --TODO: Reimplement this in a different function or scope.
    -- if self.type == "HEAL" then
    --     local key = 'HEALING_MODIFIER_FOR_PLAYER_' ..playerIndex
    --     local newHealthRegenModifier = EventItem:new()
    --     newHealthRegenModifier:set({
    --         ['playerIndex'] = playerIndex
    --     }, function (props, time)
    --         --TODO: Implement health modifier here
    --     end, function(props)
    --         --TODO: Implement a complete method here
    --     end, -1)
    --     EVENT_TABLE[key] = newHealthRegenModifier
    --     self.key = key
    -- end
    self.dir = dir
    self.modifier = modifier
end

function ItemSchema.getRef(self)
    if self.dir ~= nil then return self.dir else return nil end
end

function ItemSchema.getDescription(self)
    return self.description
end

function ItemSchema.getModifier(self)
    if self.modifier ~= nil then return self.modifier else return nil end
end

