-- BEGIN_IMPORT
-- import Raids.classes.Behaviors.functions end
-- import Raids.globals.values end
-- import Raids.modules.Events.EventTable end
-- END_IMPORT

DPS_COOLDOWN_IN_SECONDS = 130

DpsSchema = {
    name="dps",
    cooldown=false,
    cooldownTime = DPS_COOLDOWN_IN_SECONDS * 30,
    weapons={
    primary='piercer',
    secondary='reliable',
    third='',
    fourth=''
    }
}

DpsSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You now have bottomless clip for your current weapon!")
    execute_command("mag " .. playerIndex .. " 999")
    self:startCoolDown(playerIndex)
    local key = "PLAYER_" .. playerIndex .. "_IS_EXECUTING_DPS_ULTIMATE"
    local newEvent = EventTable:new()
    newEvent:set({
        ['playerIndex']=playerIndex
    }, nil, function(props) say(props.playerIndex, "Your weapon is now back to normal.") execute_command("mag " .. props.playerIndex .. " 0") end, 10 * 30)
    EVENT_TABLE[key] = newEvent
end
DpsSchema['startCoolDown'] = startCoolDown
DpsSchema['coolDownMessage'] = coolDownMessage
DpsSchema['endCoolDown'] = endCoolDown
DpsSchema['getWeapons'] = getWeapons
DpsSchema['new'] = new