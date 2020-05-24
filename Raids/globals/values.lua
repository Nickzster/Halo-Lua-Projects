-- NO_IMPORTS

WEAPON_DIR_LIST = {
    ["piercer"]="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
    ["reliable"]="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable"
}

BIPED_DIR_LIST = { 
    ["dps"]="characters\\cyborg_mp\\dps",
    ["healer"]="characters\\cyborg_mp\\healer",
    ["tank"]="zteam\\objects\\characters\\spartan\\h3\\tank",
    ["bandolier"]="bourrin\\halo reach\\marine-to-spartan\\bandolier",
    ["gunslinger"]="np\\objects\\characters\\elite\\h3\\bipeds\\gunslinger",
    ["scourge"]="h2spp\\characters\\flood\\juggernaut\\scourge",
    ["torres"]="rangetest\\cmt\\characters\\evolved_h1-spirit\\cyborg\\bipeds\\torres",
    ["eliminator"]="rangetest\\cmt\\characters\\spv3\\forerunner\\enforcer\\bipeds\\eliminator",
    ["kreyul"]="shdwslyr\\reach_elite\\ultra\\kreyul",
    ["gordius"]="cmt\\characters\\evolved\\covenant\\hunter\\bipeds\\gordius"
}

EQUIPMENT_LIST = {
    ["armor_piercing"] = {
        ["description"]="Increases your damage output",
        ["type"]="OUTPUT_DAMAGE",
        ["modifiers"]={
            ["lesser"] = 0.1,
            ["normal"] = 0.2,
            ["greater"] = 0.3, 
            ["super"] = 0.4
        }
    },
    ["armor"]={
        ["description"]="Reduces damage you take",
        ["type"]="INPUT_DAMAGE",
        ["modifiers"]={
            ["lesser"] = 0.1,
            ["normal"] = 0.2,
            ["greater"] = 0.3,
            ["super"] = 0.4
        }
    },
    ["reflective_shields"]={
        ["description"]="Gives you a percentage chance to ignore damage",
        ["type"]="INPUT_DAMAGE",
        ["modifiers"]= {
            ["lesser"] = 20,
            ["normal"] = 10,
            ["greater"] = 5,
            ["super"] = 4
        }
    },
    ["regeneration"]={
        ["description"]="Slowly regens health over time",
        ["type"]="SELF_HEALING",
        ["modifiers"]={
            ["lesser"] = 0.025,
            ["normal"] = 0.01,
            ["greater"] = 0.05,
            ["super"] = 0.1
        }
    },
    ["power_armor"]={
        ["description"]="Gives you a damage immunity after you take damage",
        ["type"]="INVINCIBILITY_PERIOD",
        ["modifiers"]= {
            ["lesser"] = 1,
            ["normal"] = 3,
            ["greater"] = 5,
            ["super"] = 8
        }
    }
}

LOCATIONS= {
    ["torres_event_1"] = "an important computer!"
}

BIPED_TAG_LIST = {}

ACTIVE_PLAYER_LIST = {}

ACTIVE_BOSSES = {}

-- MOVED TO Raids.modules.events.EventTable
-- EVENT_TABLE = {}



