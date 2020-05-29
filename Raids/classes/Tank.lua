-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Behaviors.functions end
-- import Raids.modules.Events.EventItem end
-- import Raids.modules.Events.EventTable end
-- END_IMPORT

TANK_COOLDOWN_IN_SECONDS = 100

TankSchema = {
    name="tank",
    cooldown=false,
    cooldownTime = TANK_COOLDOWN_IN_SECONDS * 30,
    maxHealth=500,
}

TankSchema['ultimate'] = function(self, playerIndex)
    say(playerIndex, "You are now temporarly invincible!")
    execute_command("god " .. playerIndex)
    local key = "PLAYER_" .. playerIndex .. "_IS_EXECUTING_TANK_ULTIMATE"
    self:startCoolDown(playerIndex)
    local ungodEvent = EventItem:new()
    ungodEvent:set({
        ['playerIndex']=playerIndex
    }, nil, function(props) execute_command("ungod " .. props.playerIndex) say(props.playerIndex, "You are no longer invincible!") end, 10 * 30)
    EventTable:addEvent(key, ungodEvent)
end

TankSchema['getClassName'] = getClassName
TankSchema['startCoolDown'] = startCoolDown
TankSchema['coolDownMessage'] = coolDownMessage
TankSchema['endCoolDown'] = endCoolDown
TankSchema['new'] = new

