-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.modules.Events.EventItem end
-- import Raids.classes.Behaviors.functions end
-- END_IMPORT

ItemSchema = {
    ['name']=nil,
    ['description']=nil,
    ['type']=nil,
    ['modifier']=nil,
    ['key']=nil
}

ItemSchema['new'] = new

function ItemSchema:destroyItem()

end

function ItemSchema:createItem(name, description, type, modifier, playerIndex) 
    self.name = name
    self.description = description
    self.type = type
    if self.type == "HEALING_MODIFIER" then
        local key = 'HEALING_MODIFIER_FOR_PLAYER_' ..playerIndex
        local newHealthRegenModifier = EventItem:new()
        newHealthRegenModifier:set({
            ['playerIndex'] = playerIndex
        }, function (props, time)
            --TODO: Implement health writing here
        end, function(props)
            --TODO: Implement a complete method here
        end, -1)
        EVENT_TABLE[key] = newHealthRegenModifier
        self.key = key
    end
    self.modifier = modifier
end

