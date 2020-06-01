-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.modules.Events.EventTable end
-- import Raids.modules.Events.EventItem end
-- import Raids.classes.Player end
-- END_IMPORT

GREED_TABLE = nil
NEED_TABLE = nil

LOOT_TABLE = {
    gordius = {
        'mightofgordius',
        'shardofgordius',
        'mightofgordius',
        'shardofgordius',
        'mightofgordius',
        'shardofgordius',
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

function rewardLoot(bossName)
    math.randomseed(os.time())
    local number = math.random(6)
    local item = LOOT_TABLE[bossName][number]
    --queue up roll event
    GREED_TABLE = {}
    NEED_TABLE = {}
    rollEvent = EventItem:new()
    say_all("Boss " .. bossName .. " drops loot " .. item)
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
            say_all(get_var(winner, "$name") .. " wins item " .. winningItem)
            local hash = get_var(winner, "$hash")
            ACTIVE_PLAYER_LIST[hash]:addItemToInventory(winningItem)
        else
            say_all("The player who won is no longer present, so the item is destroyed!")
        end
    end, 30 * 30)
    EventTable:addEvent('gordius_drop_1', rollEvent)
end