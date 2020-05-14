-- NO_IMPORTS

HEALER_COOLDOWN_IN_SECONDS = 25

HealerSchema = {
    name="healer",
    cooldown=false,
    cooldownTime = HEALER_COOLDOWN_IN_SECONDS * 30,
    weapons={
        primary='lightbringer',
        secondary='faithful',
        third='',
        fourth=''
    }
 }