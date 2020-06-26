-- BEGIN_IMPORT
-- import Raids.classes.Player end
-- import Raids.globals.RaidItems end
-- import Raids.globals.values end
-- END_IMPORT

STANDARD_CRATE_LOOTERS = {}


Crates = {
    standardcrate = {
        numberOfItems=4,
        contents={
            'armorpiercing',
            'shieldgenerator',
            'luckybullet',
            'luckytabi'
        }
    },
    heroiccrate = {
        numberOfItems=7,
        contents={
            'dpstierone',
            'tanktierone',
            'healertierone',
            'deathwarrant',
            'charity',
            'widowmaker',
            'lawman'
        }
    },
    legendarycrate = {
        numberOfItems=8,
        contents={
            'dpstiertwo',
            'tanktiertwo',
            'healertiertwo',
            'bandoliertiertwo',
            'chicagotypewriter',
            'kingsglaive',
            'lobber',
            'covert'
        }
    },
    mythiccrate = {
        numberOfItems=3,
        contents={
            'thor',
            'grimreaper',
            'piety'
        }
    },
    eclipsecrate={
        numberOfItems=2,
        contents={
            'linearity',
            'lawman'
        }
    }
}

function handleCrate(player, crateName)
    local contents = Crates[crateName]['contents']
    local numberOfItems = Crates[crateName]['numberOfItems']
    math.randomseed(os.time())
    local number = math.random(numberOfItems)
    local item = contents[number]
    print("\n\n#####################################################")
    print("The loot event rolls a " .. number)
    print("The " .. ITEM_LIST[item].pretty .. " is looted!")
    print("#####################################################\n\n")
    if player_present(player:getPlayerIndex()) then
        say_all(get_var(player:getPlayerIndex(), "$name") .. " just looted a " .. ITEM_LIST[item].pretty)
        player:addItemToInventory(item)
    end
end

function reward(player, crateName)
    if Crates[crateName] ~= nil then
        local keyname = crateName .. "key"
        if crateName == "standardcrate" then
            if STANDARD_CRATE_LOOTERS[get_var(player:getPlayerIndex(), "$hash")] == nil then
                STANDARD_CRATE_LOOTERS[get_var(player:getPlayerIndex(), "$hash")] = true
                handleCrate(player, crateName)
            else
                say(player:getPlayerIndex(), "You have already looted this crate!")
            end
        else
            if player:checkForItem(keyname) then
                handleCrate(player, crateName)
                player:removeItemFromInventory(keyname)
            else
                say(player:getPlayerIndex(), "You need a " .. ITEM_LIST[keyname].pretty .. " to loot this chest!")
            end
        end
    end
end
