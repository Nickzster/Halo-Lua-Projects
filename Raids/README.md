# RAIDS DOCUMENTATION

## [View the demo here.](https://www.youtube.com/watch?v=7gZx3zZMhaY)

### What is Raids?

- Raids is a dungeon-styled gametype for Halo Custom Edition, in which players must work together to defeat bosses.

### Classes

- Each class in raids serves a function that is essential to killing the boss. Each class has a set of weapons to choose from, and an ultimate ability. Players can also use equipment to enhance their player's damage, damage reduction, dodge, and critical stike.

## Spartan (Tank)

- Purpose: To hold agro, and have the boss attack them
- Max Health: 500
- Ultimate Ability: God mode for 10 seconds
- Ultimate Ability cooldown: 90 seconds.

## Medic (Healer)

- Purpose: To heal other players
- Max Health: 100
- Ultimate Ability: Heal all players nearby to full health.
- Ultimate Ability cooldown: 75 seconds.
- Special Notes: Healers can shoot friendly players to heal them, and shoot bosses to deal damage.

## Soldier (DPS)

- Purpose: To deal damage to the boss.
- Max Health: 100
- Ultimate Ability: Bottomless clip for 10 seconds.
- Ultimate Ability cooldown: 60 seconds.

## Valiant (Gunslinger)

- Purpose: To deal damage to the boss from a distance.
- Max Health: 100
- Ultimate Ability: Active camoflage for 30 seconds.
- Ultimate Ability cooldown: 90 seconds
- Special Notes: Is an elite.

## Bandolier

- Purpose: To deal sustained damage to the boss.
- Max Health: 100
- Ultimate Ability: Fill all nearby player's ammo to full capacity
- Ultimate Ability cooldown: 75 seconds.

# COMMANDS

```md
/class <classname> | changes your class to <classname>
/loadout <primary> <secondary> | changes your current class's loadout to <primary> and <secondary>
/equip <equipment> | equip <equipment> to your player
/ult | Activates your ultimate ability. You can press flashlight key to activate this now!
/greed | Perform a greed roll for a boss drop.
/need | Perform a need roll for a boss drop.
/whoami | Prints your current class
/moreinfo <item> | Read more information about a specified item in the mod
```

# RAID SIZES

- The raid will automatically scale depending on the number of players present. Here are some metrics you can expect depending on the number of players

## Extra Small Raid

- 0 - 3 players
- 1 Tank Allowed
- 1 Healer Allowed
- 1 Bandolier Allowed
- Boss Health is scaled at 1.0 normal health.
- If a boss has 1000 health, then the boss will have 1000 health in an extra small raid.

## Small Raid

- 4 - 5 Players
- 1 Tank Allowed
- 1 Healer Allowed
- 1 Bandolier Allowed
- Boss Health is scaled at 1.5 normal health.
- If a boss has 1000 health, then the boss will have 1500 health in a small raid.

## Medium Raid

- 6 - 10 Players
- 1 Tank is allowed
- 2 Healers are allowed
- 1 Bandolier is allowed
- Boss Health is scaled at 3.0 normal health.
- If a boss has 1000 health, then the boss will have 3000 health in a medium raid.

## Large Raid

- 11 - 12 Players
- 2 Tanks are allowed
- 2 Healers are allowed
- 1 Bandolier is allowed
- Boss Health is scaled at 5.0 normal health
- If a boss has 1000 health, then the boss will have 5000 health in a large raid

## Extra Large Raid

- 13 - 15 Players
- 2 Tanks are allowed
- 2 Healers are allowed
- 2 Bandoliers are allowed
- Boss Health is scaled at 10.0 normal health
- If a boss has 1000 health, then they will have 10,000 health in an extra large raid.

# Crates

- Crates are physical entities that players can find in the map. They come in three different flavors:

### Iron Crate

- Drops Equipment based items.

### Gold Crate

- Drops Armor based items.

### Crystal Crate

- Drops Weapon based items.

# Build Instructions

You have two options to use Raids:

1. Take the Raids.lua file in the home directory, and load that with SAPP.

2. Use the `bundler.py` file in this directory, and just run `python3 bundler.py` to build a new version of the script. Raids uses the LUA bundler that I built for LUA/SAPP, which you can [read more about here.](https://github.com/Nickzster/Lua-Bundler-For-SAPP)
