-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.globals.values end
-- import Raids.modules.Events.EventItem end
-- END_IMPORT

DPS_COOLDOWN_IN_SECONDS = 70

DpsSchema = {
    name="dps",
    cooldown=false,
    cooldownTime = DPS_COOLDOWN_IN_SECONDS * 30,
    maxHealth=100,
    weapons={
    primary='piercer',
    secondary='reliable',
    third='',
    fourth=''
    }
}

DpsSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "All of your weapons now have bottomless clip!")
    execute_command("mag " .. playerIndex .. " 999 5")
    self:startCoolDown(playerIndex)
    local key = "PLAYER_" .. playerIndex .. "_IS_EXECUTING_DPS_ULTIMATE"
    local newEvent = EventItem:new()
    newEvent:set({
        ['playerIndex']=playerIndex
    }, nil, function(props) say(props.playerIndex, "Your weapons are now back to normal.") execute_command("mag " .. props.playerIndex .. " 0 5") end, 10 * 30)
    EVENT_TABLE[key] = newEvent
end
DpsSchema['startCoolDown'] = startCoolDown
DpsSchema['coolDownMessage'] = coolDownMessage
DpsSchema['endCoolDown'] = endCoolDown
DpsSchema['getWeapons'] = getWeapons
DpsSchema['new'] = new