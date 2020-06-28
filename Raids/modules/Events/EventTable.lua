-- BEGIN_IMPORT
-- import Raids.modules.events.EventItem end
-- END_IMPORT


--singleton
EventTable = {
    Events={}
}



function EventTable.addEvent(self, eventKey, newEvent) 
    EventTable.Events[eventKey] = newEvent
end

function EventTable.addTimedEvent(self, key, cb, time) end

function EventTable.addConditionalEvent(self, key, conditional) end

function EventTable.getEvent(self, eventKey)
    return EventTable.Events[eventKey]
end

function EventTable.removeEvent(self, eventKey) 
    EventTable.Events[eventKey] = nil
end

function EventTable.cycle(self) 
    for key,_ in pairs(EventTable.Events) do
        local e = EventTable.Events[key]
        if e:isTimedOut() == true then
            EventTable:removeEvent(key)
        end
    end
end

