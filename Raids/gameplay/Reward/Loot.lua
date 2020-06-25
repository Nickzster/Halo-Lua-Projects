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

LOOT_TABLE = {
    gordius = {
        'mightofgordius',
        'shardofgordius',
        'mightofgordius',
        'shardofgordius',
        'mightofgordius',
        'shardofgordius',
    },
    torres = {
        'torresshieldgenerator',
        'torresammopouch',
        'widowmaker',
        'torresshieldgenerator',
        'torresammopouch',
        'widowmaker'
    }
}

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
    local bossName = props.BOSS
    if LOOT_TABLE[bossName] == nil then return end
    local itemName = ITEM_LIST[item].pretty
    print("\nRewarding loot!")
    print(bossName)
    print("\nDropping loot for " .. bossName)
    math.randomseed(os.time())
    local number = math.random(6)
    local item = LOOT_TABLE[bossName][number]
    if item == nil then return end
    --queue up roll event
    GREED_TABLE = {}
    NEED_TABLE = {}
    rollEvent = EventItem:new()
    say_all("Boss " .. bossName .. " drops loot " .. itemName)
    say_all("Roll /greed or /need to receive this item.")
    rollEvent:set({
        winningItem=item
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
            say_all(get_var(winner, "$name") .. " wins item " .. itemName)
            local hash = get_var(winner, "$hash")
            ACTIVE_PLAYER_LIST[hash]:addItemToInventory(winningItem)
        else
            say_all("The player who won is no longer present, so the item is destroyed!")
        end
    end, 30 * 15)
    EventTable:addEvent(bossName.. '_drop_1', rollEvent)
end