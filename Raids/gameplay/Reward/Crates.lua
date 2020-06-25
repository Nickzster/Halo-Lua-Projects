-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.globals.RaidItems end
-- import Raids.globals.values end
-- END_IMPORT

IRON_CRATE_LOOTERS = {}

GOLD_CRATE_HAS_BEEN_LOOTED = false

CRYSTAL_CRATE_HAS_BEEN_LOOTED = false

function reward(player, lootTable)
    math.randomseed(os.time())
    local number = math.random(4)
    local item = lootTable[number]
    if player_present(player:getPlayerIndex()) then
        say_all(get_var(player:getPlayerIndex(), "$name") .. " just looted a " .. ITEM_LIST[item].pretty)
    end
    player:addItemToInventory(item)
end

IronCrateTierOne = {
    'armorpiercingone',
    'shieldgeneratorone',
    'luckybulletone',
    'luckytabione'
}

IronCrateTierTwo = {
    'armorpiercingtwo',
    'shieldgeneratortwo',
    'luckybullettwo',
    'luckytabitwo'
}

IronCrateTierThree =  {
    'armorpiercingthree',
    'shieldgeneratorthree',
    'luckybulletthree',
    'luckytabithree'
}

GoldCrateTierOne = {
    'dpstierone',
    'healertierone',
    'bandoliertiertwo',
    'tanktierone'
}

GoldCrateTierTwo = {
    'dpstiertwo',
    'healertiertwo',
    'bandoliertiertwo',
    'tanktiertwo'
}

CrystalCrateTierOne = {
    'widowmaker',
    'piety',
    'lobber',
    'grimreaper'
}
CrystalCrateTierTwo = {
    'widowmaker',
    'piety',
    'lobber',
    'grimreaper'
}
CrystalCrateTierThree = {
    'widowmaker',
    'piety',
    'lobber',
    'grimreaper'
}
CrystalCrateTierFour = {
    'widowmaker',
    'piety',
    'lobber',
    'grimreaper'
}


CRATES = {
    IronCrate=function(player) 
        reward(player, IronCrateTierOne)
    end,
    GoldCrate=function(player) 
        reward(player, GoldCrateTierOne)
    end,
    CrystalCrate=function(player) 
        reward(player, CrystalCrateTierOne)
    end,
}

function CRATES.execute(self, crateName, player)
    CRATES[crateName](player)
end