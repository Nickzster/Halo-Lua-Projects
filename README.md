# Halo LUA Projects

For a bit of context, Halo Custom Edition is a game that allows you to create custom content for the Halo: Combat Evolved game. A person named Sehe created an extension called SAPP to expand the capabilities of the Halo Game, which can be scripted using Lua. This repository consists of some of these Lua Projects that I've created.

The two that are worth mentioning in this readme is GTA Halo and Raids.

## GTA Halo

GTA Halo sounds like exactly what it's called: A Grand Theft Auto take on Halo. The GTA Halo mod features the ability to purchase weapons and vehicles, change loadouts, drive these vehicles around, a police system, and a lot more. To see some of these systems in action, you can check out these videos:

- [Persistent Vehicles in Halo](https://www.youtube.com/watch?v=ohNYc5FoEpY)
- [Persistent Weapons in Halo](https://www.youtube.com/watch?v=_PBRg54p5eI)

## Raids

Raids is a game mode inspired by a good friend of mine that likes to do boss fights in Halo. Essentially, he "plays" as the boss, while the other people fight him. You can imagine that in a regular game of Halo that this might be underwealming, as there are no options to "change" the boss's player model, or have designations that allow the players to work together.

Raids solves all of this. It implements an enriching boss experience utilizing several player classes, biped switching, dialog, music, loot drops, and tons of other cool stuff. Video to come soon!

I knew very well that this system was going to be large, so rather than overwhelming myself with writing a single script file, I built a bundler that allows me to modularize the code for this project, and bundle it into a single file at the end. The repository for that project can be found [here.](https://github.com/Nickzster/Lua-Bundler-for-SAPP)
