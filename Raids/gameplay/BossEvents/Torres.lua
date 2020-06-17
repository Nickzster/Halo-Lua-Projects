-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Player end
-- import Raids.modules.Events.EventItem end
-- import Raids.modules.Events.EventTable end
-- END_IMPORT

SavantEventCompleted = function(props) 
    say_all("Savant Deployed! We dropped it on the roof with the computer!")
    spawn_object("weap", "bourrin\\halo3\\weapons\\spartan_laser\\savant", -18.52,-27.71,10)
end

LocationEventCompleted = function(props) 
    say_all("Message Received. Savant Drop is on it's way!")
    savantEventComplete = EventItem:new()
    savantEventComplete:set({}, nil, SavantEventCompleted, 30 * 120)
    EventTable:addEvent('savantEventComplete', savantEventComplete)
end

NotifyPlayersCompleted = function(props) 
    say_all("Be on the look out for a special computer!")
    locationEventComplete = EventItem:new()
    locationEventComplete:set({}, function(props, time)
        for i=1,16 do
            if player_present(i) and player_alive(i) then
                local hash = get_var(i, "$hash")
                if ACTIVE_PLAYER_LIST[hash]:isInLocation("torres_event_1") then
                    return true
                end
            end
        end
        return false
    end, LocationEventCompleted, -1)
    EventTable:addEvent("LocationEventTorres", locationEventComplete)
end

