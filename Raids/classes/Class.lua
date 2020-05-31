-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Behaviors.functions end
-- import Raids.modules.Events.EventItem end
-- import Raids.modules.Events.EventTable end
-- END_IMPORT

ClassSchema = {
    name="BaseClass",
    cooldown=false,
    ultCooldownTime=0,
}

ClassSchema['new'] = new

function ClassSchema.ultimate(self, playerIndex)
    say(playerIndex, "This class does not have an ultimate!")
end

function ClassSchema.instantiate(self, name, cooldownTime)
    self.name = name
    self.ultCooldownTime = cooldownTime
    return self
end

function ClassSchema.getClassName(self)
    return self.name
end

coolDownMessage = function(props, time)
    local playerIndex = props.playerIndex
    if playerIndex ~= nil then
        if time == 10 * 30 then
            say(playerIndex, "Ultimate ability will be ready in 10 seconds!")
        end
    end
end

endCoolDown = function(props)
    local obj = props.self
    local playerIndex = props.playerIndex
    obj.cooldown = false
    obj.cooldownStatus = nil
    if playerIndex ~= nil then
        say(playerIndex, "Ultimate ability is ready to use again!")
    end
end


function ClassSchema.startCoolDown(self, playerIndex)
    self.cooldown = true
    key = self.name .. playerIndex
    self.cooldownStatus = key
    newEventItem = EventItem:new()
    newEventItem:set({
        ['self']=self,
        ['playerIndex']=playerIndex
    }, coolDownMessage, endCoolDown, self.ultCooldownTime)
    EventTable:addEvent(key, newEventItem)
end



