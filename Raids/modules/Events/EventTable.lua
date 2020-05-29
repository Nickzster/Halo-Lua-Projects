-- BEGIN_IMPORT
-- import Raids.modules.events.EventItem end
-- END_IMPORT


--singleton
EventTable = {}

function EventTable.addEvent(self, eventKey, newEvent) 
    EventTable[eventKey] = newEvent
end

function EventTable.getEvent(self, eventKey)
    return EventTable[eventKey]
end

function EventTable.removeEvent(self, eventKey) 
    EventTable[eventKey] = nil
end

function EventTable.cycle(self) 
    for key,_ in pairs(EventTable) do
        if EventTable[key] ~= EventTable.addEvent 
        and EventTable[key] ~= EventTable.removeEvent 
        and EventTable[key] ~= EventTable.cycle
        and EventTable[key] ~= EventTable.getEvent then
            if EventTable[key]:isTimedOut() == true then
                EventTable:removeEvent(key)
            end
        end
    end
end