-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Player end
-- import Raids.modules.Events.EventItem end
-- END_IMPORT

SavantEventCompleted = function(props) 
    say_all("Savant Deployed! It's near the center walkway!")
    spawn_object("weap", "halo reach\\objects\\weapons\\support_high\\spartan_laser\\savant", 105.62, 342.36, -3)
end

LocationEventCompleted = function(props) 
    say_all("Message Received. Savant Drop is on it's way!")
    savantEventComplete = EventItem:new()
    savantEventComplete:set({}, nil, SavantEventCompleted, 30 * 120)
    EVENT_TABLE["savantEventComplete"] = savantEventComplete
end

NotifyPlayersCompleted = function(props) 
    say_all("Be on the look out for a special computer!")
    locationEventComplete = EventItem:new()
    locationEventComplete:set({}, function(props, time)
        for i=1,16 do
            if player_present(i) then
                local hash = get_var(i, "$hash")
                if ACTIVE_PLAYER_LIST[hash]:isInLocation("torres_event_1") then
                    return true
                end
            end
        end
        return false
    end, LocationEventCompleted, -1)
    EVENT_TABLE["LocationEventTorres"] = locationEventComplete
end

