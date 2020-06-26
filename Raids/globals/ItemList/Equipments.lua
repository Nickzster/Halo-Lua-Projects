-- NO_IMPORTS

EquipmentList = {
    armorpiercing={
        pretty="Armor Piercing 1",
        description="Increases your damage output!",
        type="DAMAGE_BOOST",
        modifier=1.4
    },
    shieldgenerator={
        pretty="Shield Generator 1",
        description="Decrases the amount of damage you take!",
        type="DAMAGE_REDUCE",
        modifier=1.4
    },
    luckybullet={
        pretty="Lucky Bullet 1",
        description="Has a chance to increase your damage significantly!",
        type="DAMAGE_CRIT_STRIKE",
        rng=20,
        modifier=3
    },
    luckytabi={
        pretty="Lucky Tabi 1",
        description="Has a chance to completely ignore damage!",
        type="DAMAGE_IGNORE",
        rng=20
    },
    godlytabi={
        pretty="Godly Tabi",
        description="If you wear this, you're practically invincible!",
        type="DAMAGE_IGNORE",
        rng=2
    },
    godlybullet={
        pretty="Godly Bullet",
        description="If you wear this, you're doing the reaper's work for him!",
        type="DAMAGE_CRIT_STRIKE",
        rng=2,
        modifier=10
    },
    mightofgordius = {
        pretty="Might of Gordius",
        description="The Might of Gordius increases your damage!",
        type="DAMAGE_BOOST",
        modifier=1.5
    },
    shardofgordius = {
        pretty="Shard of Gordius",
        description="The Shard of Gordius protects you from damage!",
        type="DAMAGE_REDUCE",
        modifier=1.5
    },
    torresshieldgenerator={
        pretty="Torres's Shield Generator",
        description="Torres's Shield Generator protects you from damage!",
        type="DAMAGE_REDUCE",
        modifier=1.5
    },
    torresammopouch={
        pretty="Torres's Ammo Pouch",
        description="Torres's Ammo Pouch boosts your damage!",
        type="DAMAGE_BOOST",
        modifier=1.5
    },
    eliminatorshield={
        pretty = "The Eliminator's Shield",
        description="The Eliminator's Shield graces you with protection.",
        type="DAMAGE_IGNORE",
        rng=5
    },
    beamoflight={
        pretty="The Beam of Light",
        description="The Beam of Light boosts your damage!",
        type="DAMAGE_BOOST",
        modifier=2.0
    }
}