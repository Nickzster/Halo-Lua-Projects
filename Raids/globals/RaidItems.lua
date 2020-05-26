-- NO_IMPORTS

--types
-- WEAPON- A reference to a weapon file
-- OUTPUT_DAMAGE: Multiplies the incoming base damage for a weapon by the modifier amount, and adds it to the base damage value.
-- INPUT_DAMAGE: Multiplies the incoming base damage for a weapon by the modifier amount, and subtracts it from the base damage value.
-- INVINCIBILITY: Specifies the length of invunerability the item has in ticks.
-- IGNORE: Specifies the upper bounds of the RNG to ignore damage.
-- HEAL: Specifies the amount of health to regenerate every second.

ITEM_LIST = {
    piercer={
        description="Battle Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
        modifier=nil,
        classes={
            dps=true
        }
    },
    reliable={
        description="Assault Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable",
        modifier=nil,
        classes={
            dps=true
        }
    },
    accelerator={
        description="MA5K",
        type="WEAPON",
        dir="altis\\weapons\\br\\accelerator",
        modifier=nil,
        classes={
            bandolier=true
        }
    },
    limitless={
        description="MG",
        type="WEAPON",
        dir="rangetest\\cmt\\weapons\\spv3\\human\\turret\\limitless",
        modifier=nil,
        classes={
            bandolier=true
        }
    },
    discordant={
        description="Concussion Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\concussion_rifle\\hr\\discordant",
        modifier=nil,
        classes={
            gunslinger=true
        }
    },
    irradiator={
        description="Carbine",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\covenant_carbine\\h3\\irradiator",
        modifier=nil,
        classes={
            gunslinger=true
        }
    },
    brassknuckle={
        description="Mauler",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\mauler\\h3\\brassknuckle",
        modifier=nil,
        classes={
            tank=true
        }
    },
    faithful={
        description="Plasma Pistol",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\plasma_pistol\\h3\\faithful",
        modifier=nil,
        classes={
            healer=true
        }
    },
    lightbringer={
        description="Plasma Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\plasma_rifle\\h3\\lightbringer",
        modifier=nil,
        classes={
            healer=true
        }
    },
    rampart={
        description="Spiker",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\spike_rifle\\h3\\rampart",
        modifier=nil,
        classes={
            tank=true
        }
    },
    armor_piercing={
        description="Increases your damage output",
        type="OUTPUT_DAMAGE",
        dir=nil,
        modifier=0.4,
        classes=nil
    },
    armor={
        description="Reduces the damage you take",
        type="INPUT_DAMAGE",
        dir=nil,
        modifier=0.4,
        classes=nil
    }
}
