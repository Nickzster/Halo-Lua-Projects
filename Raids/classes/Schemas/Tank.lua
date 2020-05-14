-- NO_IMPORTS

TANK_COOLDOWN_IN_SECONDS = 25

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

