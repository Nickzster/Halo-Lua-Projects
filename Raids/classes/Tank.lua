-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Behaviors.functions end
-- import Raids.modules.Events.EventTable end
-- END_IMPORT

TANK_COOLDOWN_IN_SECONDS = 127

TankSchema = {
    name="tank",
    cooldown=false,
    cooldownTime = TANK_COOLDOWN_IN_SECONDS * 30,
    weapons= {
    primary='brassknucle',
    secondary='rampart',
    third='',
    fourth=''
    }
}

TankSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You are now temporarly invincible!")
    execute_command("god " .. playerIndex)
    local key = "PLAYER_" .. playerIndex .. "_IS_EXECUTING_TANK_ULTIMATE"
    self:startCoolDown(playerIndex)
    local ungodEvent = EventTable:new()
    ungodEvent:set({
        ['playerIndex']=playerIndex
    }, nil, function(props) execute_command("ungod " .. props.playerIndex) say(props.playerIndex, "You are no longer invincible!") end, 7 * 30)
    EVENT_TABLE[key] = ungodEvent
end
TankSchema['startCoolDown'] = startCoolDown
TankSchema['coolDownMessage'] = coolDownMessage
TankSchema['endCoolDown'] = endCoolDown
TankSchema['getWeapons'] = getWeapons
TankSchema['new'] = new

