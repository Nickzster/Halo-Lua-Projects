-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.modules.Events.EventTable end
-- import Raids.modules.Events.EventItem end
-- import Raids.classes.Player end
-- END_IMPORT

GREED_TABLE = nil
NEED_TABLE = nil

-- NOTE
-- WHEN MODIFYING LOOT TABLE
-- ADD ITEMS TO LOOT TABLE
-- AND PRETTY TABLE!!!

LOOT_TABLES = {
    gordius = {
        numberOfItems=3,
        loot={
            'mightofgordius',
            'shardofgordius',
            'heroiccratekey'
        }
    },
    torres = {
        numberOfItems=4,
        loot={
            'torresshieldgenerator',
            'torresammopouch',
            'widowmaker',
            'heroiccratekey'
        }
    },
    eliminator = {
        numberOfItems=4,
        loot={
            'heroiccratekey',
            'linearity',
            'beamoflight',
            'eliminatorshield',
        }
    }
}



function keyDrop()
    local commonkey = 'heroiccratekey'
    local rarekey = 'legendarycratekey'
    local superrarekey = 'mythiccratekey'
    math.randomseed(os.time())
    local commonroll = math.random(50)
    local rareroll = math.random(100)
    local superrareroll = math.random(200)
    print("\n\n#####################################################")
    print("Common Key Roll: " .. commonroll)
    print("Rare Key Roll: " .. rareroll)
    print("Super Rare Key Roll: " .. superrareroll)
    print("#####################################################\n\n")
    if commonroll == 1 then
        say_all("Everyone has been rewarded with a " .. ITEM_LIST[commonkey].pretty)
        for i in pairs(ACTIVE_PLAYER_LIST) do 
            ACTIVE_PLAYER_LIST[i]:addItemToInventory(commonkey)
        end
    end
    if rareroll == 1 then
        say_all("Everyone has been rewarded with a " .. ITEM_LIST[rarekey].pretty)
        for i in pairs(ACTIVE_PLAYER_LIST) do 
            ACTIVE_PLAYER_LIST[i]:addItemToInventory(rarekey)
        end
    end
    if superrareroll == 1 then
        say_all("Everyone has been rewarded with a " .. ITEM_LIST[superrarekey].pretty)
        for i in pairs(ACTIVE_PLAYER_LIST) do 
            ACTIVE_PLAYER_LIST[i]:addItemToInventory(superrarekey)
        end
    end
end

function computeLoot(playerTable)
    local highest = 0
    local highestIndex = 0
    for key,_ in pairs(playerTable) do
        local newHighest = playerTable[key].roll
        if newHighest > highest then
            highest = newHighest
            highestIndex = playerTable[key].player
        end
    end
    return highestIndex
end

function rewardLoot(props)
    math.randomseed(os.time())
    local bossName = props.BOSS
    if bossName ~= "DEFAULT" then 
        keyDrop()
    end
    -- cancel loot process if boss does not have item
    if LOOT_TABLES[bossName] == nil then return end
    -- compute loot
    local number = math.random(LOOT_TABLES[bossName]['numberOfItems'])
    local itemKey = LOOT_TABLES[bossName]['loot'][number]
    if itemKey == nil or ITEM_LIST[itemKey] == nil then return end
    local displayName = ITEM_LIST[itemKey].pretty
    -- Debug log
    print("\n\n#####################################################")
    print("Dropping loot for " .. bossName)
    print("The loot event rolls a " .. number)
    print("The " .. displayName .. " is dropped!")
    print("#####################################################\n\n")
    --queue up roll event
    GREED_TABLE = {}
    NEED_TABLE = {}
    rollEvent = EventItem:new()
    say_all("Boss " .. bossName .. " drops loot " .. displayName)
    say_all("Roll /greed or /need to receive this item.")
    rollEvent:set({
        winningItem=itemKey,
        display=displayName
    }, nil, function(props) 
        local winningItem = props.winningItem
        local winner = 1
        if #NEED_TABLE > 0 then
            winner = computeLoot(NEED_TABLE)
        elseif #GREED_TABLE > 0 then
            winner = computeLoot(GREED_TABLE)
        else
            say_all("No one rolled on item, so it is destroyed!")
            return
        end
        if player_present(winner) then
            say_all(get_var(winner, "$name") .. " wins item " .. props.display)
            local hash = get_var(winner, "$hash")
            ACTIVE_PLAYER_LIST[hash]:addItemToInventory(winningItem)
        else
            say_all("The player who won is no longer present, so the item is destroyed!")
        end
    end, 30 * 30)
    EventTable:addEvent(bossName.. '_drop_1', rollEvent)
end