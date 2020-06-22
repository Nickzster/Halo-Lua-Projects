-- NO_IMPORTS

--types
-- WEAPON- A reference to a weapon file
-- DAMAGE_BOOST: Multiplies the incoming base damage for a weapon by the modifier amount, and adds it to the base damage value.
-- DAMAGE_REDUCE: Multiplies the incoming base damage for a weapon by the modifier amount, and subtracts it from the base damage value.
-- DAMAGE_INVINCIBILITY_PERIOD: Specifies the length of invunerability the item has in ticks.
-- DAMAGE_IGNORE: Specifies the upper bounds of the RNG to ignore damage.
-- HEAL: Specifies the amount of health to regenerate every second.

ITEM_LIST = {
    piercer={
        description="Battle Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer",
        maxAmmo=684,
        classes={
            dps=true
        }
    },
    reliable={
        description="Assault Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\assault_rifle\\h3\\reliable",
        maxAmmo=676,
        classes={
            dps=true
        }
    },
    accelerator={
        description="MA5K",
        type="WEAPON",
        ref="altis\\weapons\\br\\accelerator",
        maxAmmo=676,
        classes={
            bandolier=true
        }
    },
    limitless={
        description="MG",
        type="WEAPON",
        ref="rangetest\\cmt\\weapons\\spv3\\human\\turret\\limitless",
        maxAmmo=600,
        classes={
            bandolier=true
        }
    },
    lobber={
        description="Grenade Launcher",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\grenade_launcher\\hr\\lobber",
        maxAmmo=40,
        classes={
            bandolier=true
        }
    },
    lawman={
        description="DMR",
        type="WEAPON",
        ref="bourrin\\weapons\\dmr\\lawman",
        maxAmmo=500,
        classes={
            bandolier=true
        }
    },
    irradiator={
        description="Carbine",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\covenant_carbine\\h3\\irradiator",
        maxAmmo=636,
        classes={
            gunslinger=true
        }
    },
    brassknuckle={
        description="Mauler",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\mauler\\h3\\brassknuckle",
        maxAmmo=505,
        classes={
            tank=true
        }
    },
    rampart={
        description="Spiker",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\spike_rifle\\h3\\rampart",
        maxAmmo=1000,
        classes={
            tank=true
        }
    },
    faithful={
        description="Plasma Pistol",
        type="WEAPON",
        battery=true,
        ref="h2\\objects\\weapons\\pistol\\plasma_pistol\\faithful",
        maxBattery=100,
        classes={
            healer=true
        }
    },
    lightbringer={
        description="Plasma Rifle",
        type="WEAPON",
        battery=true,
        ref="h2\\objects\\weapons\\rifle\\plasma_rifle\\lightbringer",
        maxBattery=100,
        classes={
            healer=true
        }
    },
    piety={
        description="Brute Plasma Rifle",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="h2\\objects\\weapons\\rifle\\brute_plasma_rifle\\piety",
        classes={
            healer=true
        }
    },
    linearity={
        description="Sentinel Beam",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="h2\\objects\\weapons\\support_low\\sentinel_beam\\linearity",
        classes={
            healer=true
        }
    },
    eviscerator={
        description="Energy Sword",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="h4\\weapons\\covenant\\energy sword\\eviscerator",
        classes={
            gunslinger=true
        }
    },
    headhunter={
        description="Beam Rifle",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="zteam\\objects\\weapons\\single\\beam_rifle\\h3\\headhunter",
        classes={
            gunslinger=true
        }
    },
    discordant={
        description="Fuel Rod Cannon",
        type="WEAPON",
        ref="halo3\\weapons\\'plasma cannon'\\discordant",
        maxAmmo=30,
        classes={
            gunslinger=true
        }
    },
    concusser={
        description="Concussion Rifle",
        type="WEAPON",
        ref="zteam\\objects\\weapons\\single\\concussion_rifle\\hr\\concusser",
        maxAmmo=606,
        classes={
            gunslinger=true
        }
    },
    thor={
        description="Gravity Hammer",
        type="WEAPON",
        battery=true,
        maxBattery=100,
        ref="zteam\\objects\\weapons\\single\\gravity_hammer\\h3\\thor",
        classes={
            tank=true
        }
    },
    kingsglaive={
        description="Brute Shot",
        type="WEAPON",
        maxAmmo=42,
        ref="zteam\\objects\\weapons\\single\\brute_shot\\h3_6rounds\\kingsglaive",
        classes={
            tank=true
        }
    },
    charity={
        description="Pistol",
        type="WEAPON",
        maxAmmo=500,
        ref="zteam\\objects\\weapons\\single\\magnum\\h1\\charity",
        classes={
            healer=true
        }
    },
    grimreaper={
        description="Rocket Launcher",
        type="WEAPON",
        maxAmmo=8,
        ref="zteam\\objects\\weapons\\single\\rocket_launcher\\hr\\grimreaper",
        classes={
            dps=true
        }
    },
    deathwarrant={
        description="Shotgun",
        type="WEAPON",
        maxAmmo=60,
        ref="zteam\\objects\\weapons\\single\\shotgun\\h3\\deathwarrant",
        classes={
            tank=true
        }
    },
    chicagotypewriter={
        description="SMG",
        type="WEAPON",
        maxAmmo=400,
        ref="zteam\\objects\\weapons\\single\\smg\\h3\\chicagotypewriter",
        classes={
            healer=true
        }
    },
    widowmaker={
        description="Sniper Rifle",
        type="WEAPON",
        maxAmmo=20,
        ref="halo3\\weapons\\sniper rifle\\widowmaker",
        classes={
            dps=true
        }
    },
    covert={
        description="Ma5K Tactical Rifle",
        type="WEAPON",
        maxAmmo=250,
        ref="altis\\weapons\\br_spec_ops\\covert",
        classes={
            dps=true
        }
    },
    negotiator={
        description="Gauss Rifle",
        type="WEAPON",
        maxAmmo=40,
        ref="np\\objects\\weapons\\rifle\\gauss_sniper_rifle\\hm\\negotiator",
        classes={
            dps=true
        }
    },
    dpsstd={
        description="Standard ODST Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\soldier",
        maxHealth=100,
        defense=0,
        classes={
            dps=true
        }
    },
    dpstierone={
        description="Tier 1 Soldier Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\soldier1",
        maxHealth=115,
        defense=0,
        classes={
            dps=true
        }
    },
    dpstiertwo={
        description="Tier 2 Soldier Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\soldier2",
        maxHealth=130,
        defense=0,
        classes={
            dps=true
        }
    },
    healerstd={
        description="Standard ODST armor for medics.",
        type="ARMOR",
        ref="characters\\cyborg_mp\\medic",
        maxHealth=100,
        defense=0,
        classes={
            healer=true
        }
    },
    healertierone={
        description="Tier 1 Medic Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\medic1",
        maxHealth=115,
        defense=0,
        classes={
            healer=true
        }
    },
    healertiertwo={
        description="Tier 2 Medic Armor",
        type="ARMOR",
        ref="characters\\cyborg_mp\\medic2",
        maxHealth=130,
        defense=0,
        classes={
            healer=true
        }
    },
    tankstd={
        description="Standard MK 6 armor for tanks",
        type="ARMOR",
        ref="hcea\\characters\\cyborg\\spartan",
        maxHealth=500,
        defense=0,
        classes={
            tank=true
        }
    },
    tanktierone={
        description="Tier 1 Spartan Armor",
        type="ARMOR",
        ref="zteam\\objects\\characters\\spartan\\h3\\spartan1",
        maxHealth=550,
        defense=0,
        classes={
            tank=true
        }
    },
    tanktiertwo={
        description="Tier 2 Spartan Armor",
        type="ARMOR",
        ref="zteam\\objects\\characters\\spartan\\h3\\spartan2",
        maxHealth=600,
        defense=0,
        classes={
            tank=true
        }
    },
    bandolierstd={
        description="Standard Marine armor for Bandoliers",
        type="ARMOR",
        ref="bourrin\\halo reach\\marine-to-spartan\\bandolier",
        maxHealth=115,
        defense=0,
        classes={
            bandolier=true
        }
    },
    bandoliertiertwo={
        description="Tier 2 Bandolier Armor",
        type="ARMOR",
        ref="bourrin\\halo reach\\marine-to-spartan\\bandolier2",
        maxHealth=130,
        defense=0,
        classes={
            bandolier=true
        }
    },
    gunslingerstd={
        description="Standard Elite armor for Gunslingers",
        type="ARMOR",
        ref="np\\objects\\characters\\elite\\h3\\bipeds\\valiant",
        maxHealth=100,
        defense=0,
        classes={
            gunslinger=true
        }
    },
    gunslingertierone={
        description="Tier 1 Valiant Armor",
        type="ARMOR",
        ref="np\\objects\\characters\\elite\\hm\\bipeds\\valiant1",
        maxHealth=115,
        defense=0,
        classes={
            gunslinger=true
        }
    },
    gunslingertiertwo={
        description="Tier 2 Valiant Armor",
        type="ARMOR",
        ref="np\\objects\\characters\\elite\\hm\\bipeds\\valiant2",
        maxHealth=130,
        defense=0,
        classes={
            gunslinger=true
        }
    },
    scourge={
        description="Scourge Boss",
        type="BOSS",
        ref="h2spp\\characters\\flood\\juggernaut\\scourge",
        maxHealth=5000,
        defense=0,
        classes={
            boss=true
        }
    },
    torres={
        description="Torres Boss",
        type="BOSS",
        ref="rangetest\\cmt\\characters\\evolved_h1-spirit\\cyborg\\bipeds\\torres",
        maxHealth=27500,
        defense=0,
        classes={
            boss=true
        }
    },
    eliminator={
        description="Eliminator Boss",
        type="BOSS",
        ref="rangetest\\cmt\\characters\\spv3\\forerunner\\enforcer\\bipeds\\eliminator",
        maxHealth=2000,
        defense=0,
        classes={
            boss=true
        }
    },
    kreyul={
        description="Kreyul Boss",
        type="BOSS",
        ref="shdwslyr\\reach_elite\\ultra\\kreyul",
        maxHealth=1000,
        defense=0,
        classes={
            boss=true
        }
    },
    gordius={
        description="Gordius Boss",
        type="BOSS",
        ref="cmt\\characters\\evolved\\covenant\\hunter\\bipeds\\gordius",
        maxHealth=4000,
        defense=0,
        classes={
            boss=true
        }
    },
    DEFAULT={
        description="Default Map Biped",
        type="ARMOR",
        ref="hcea\\characters\\cyborg\\spartan",
        maxHealth=100,
        defense=0,
        classes={
            boss=true
        }
    },
    backdraft={
        description="Backdraft Boss",
        type="BOSS",
        ref="bourrin\\halo reach\\spartan\\male\\backdraft",
        maxHealth=12000,
        defense=0,
        classes={
            boss=true
        }
    },
    boom={
        description="Boom Boss",
        type="BOSS",
        ref="bourrin\\halo reach\\spartan\\male\\boom",
        maxHealth=7500,
        defense=0,
        classes={
            boss=true
        }
    },
    bewm={
        description="Bewm Boss",
        type="BOSS",
        ref="bourrin\\halo reach\\spartan\\male\\buum",
        maxHealth=8000,
        defense=0,
        classes={
            boss=true
        }
    },
    griswald={
        description="Griswald Boss",
        type="BOSS",
        ref="bourrin\\halo reach\\spartan\\male\\griswald",
        maxHealth=9000,
        defense=0,
        classes={
            boss=true
        }
    },
    mightofgordius = {
        description="The Might of Gordius increases your damage!",
        type="DAMAGE_BOOST",
        modifier=0.1
    },
    shardofgordius = {
        description="The Shard of Gordius protects you from damage!",
        type="DAMAGE_REDUCE",
        modifier=0.1
    },
    torresshieldgenerator={
        description="Torres's Shield Generator protects you from damage!",
        type="DAMAGE_REDUCE",
        modifier=0.1
    },
    torresammopouch={
        description="Torres's Ammo Pouch boosts your damage!",
        type="DAMAGE_BOOST",
        modifier=0.1
    }
}
