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
        dir="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
        maxAmmo=612,
        modifier=0,
        classes={
            dps=true
        }
    },
    reliable={
        description="Assault Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable",
        maxAmmo=612,
        modifier=0,
        classes={
            dps=true
        }
    },
    accelerator={
        description="MA5K",
        type="WEAPON",
        dir="altis\\weapons\\br\\accelerator",
        maxAmmo=612,
        modifier=0,
        classes={
            bandolier=true
        }
    },
    limitless={
        description="MG",
        type="WEAPON",
        dir="rangetest\\cmt\\weapons\\spv3\\human\\turret\\limitless",
        maxAmmo=500,
        modifier=0,
        classes={
            bandolier=true
        }
    },
    discordant={
        description="Concussion Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\concussion_rifle\\hr\\discordant",
        maxAmmo=594,
        modifier=0,
        classes={
            gunslinger=true
        }
    },
    irradiator={
        description="Carbine",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\covenant_carbine\\h3\\irradiator",
        maxAmmo=612,
        modifier=0,
        classes={
            gunslinger=true
        }
    },
    brassknuckle={
        description="Mauler",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\mauler\\h3\\brassknuckle",
        maxAmmo=495,
        modifier=0,
        classes={
            tank=true
        }
    },
    rampart={
        description="Spiker",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\spike_rifle\\h3\\rampart",
        maxAmmo=920,
        modifier=0,
        classes={
            tank=true
        }
    },
    faithful={
        description="Plasma Pistol",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\plasma_pistol\\h3\\faithful",
        maxBattery=100,
        modifier=0,
        classes={
            healer=true
        }
    },
    lightbringer={
        description="Plasma Rifle",
        type="WEAPON",
        dir="zteam\\objects\\weapons\\single\\plasma_rifle\\h3\\lightbringer",
        maxBattery=100,
        modifier=0,
        classes={
            healer=true
        }
    },
    armor_piercing={
        description="Increases your damage output",
        type="OUTPUT_DAMAGE",
        dir=nil,
        damageModifier=0.4,
        classes=nil
    },
    dps_std_armor={
        description="Standard ODST Armor",
        type="ARMOR",
        dir="characters\\cyborg_mp\\dps",
        maxHealth=100,
        defense=0,
        classes={
            dps=true
        }
    },
    healer_std_armor={
        description="Standard ODST armor for medics.",
        type="ARMOR",
        dir="characters\\cyborg_mp\\healer",
        maxHealth=100,
        defense=0,
        classes={
            healer=true
        }
    },
    tank_std_armor={
        description="Standard MK 6 armor for tanks",
        type="ARMOR",
        dir="zteam\\objects\\characters\\spartan\\h3\\tank",
        maxHealth=500,
        defense=0,
        classes={
            tank=true
        }
    },
    bandolier_std_armor={
        description="Standard Marine armor for Bandoliers",
        type="ARMOR",
        dir="bourrin\\halo reach\\marine-to-spartan\\bandolier",
        maxHealth=100,
        defense=0,
        classes={
            bandolier=true
        }
    },
    gunslinger_std_armor={
        description="Standard Elite armor for Gunslingers",
        type="ARMOR",
        dir="np\\objects\\characters\\elite\\h3\\bipeds\\gunslinger",
        maxHealth=100,
        defense=0,
        classes={
            gunslinger=true
        }
    },
    scourge_boss={
        description="Scourge Boss",
        type="BOSS",
        dir="h2spp\\characters\\flood\\juggernaut\\scourge",
        maxHealth=5000,
        defense=0,
        classes={
            boss=true
        }
    },
    torres_boss={
        description="Torres Boss",
        type="BOSS",
        dir="rangetest\\cmt\\characters\\evolved_h1-spirit\\cyborg\\bipeds\\torres",
        maxHealth=1500,
        defense=0,
        classes={
            boss=true
        }
    },
    eliminator_boss={
        description="Eliminator Boss",
        type="BOSS",
        dir="rangetest\\cmt\\characters\\spv3\\forerunner\\enforcer\\bipeds\\eliminator",
        maxHealth=2000,
        defense=0,
        classes={
            boss=true
        }
    },
    kreyul_boss={
        description="Kreyul Boss",
        type="BOSS",
        dir="shdwslyr\\reach_elite\\ultra\\kreyul",
        maxHealth=1000,
        defense=0,
        classes={
            boss=true
        }
    },
    gordius_boss={
        description="Gordius Boss",
        type="BOSS",
        dir="cmt\\characters\\evolved\\covenant\\hunter\\bipeds\\gordius",
        maxHealth=4000,
        defense=0,
        classes={
            boss=true
        }
    }
}
