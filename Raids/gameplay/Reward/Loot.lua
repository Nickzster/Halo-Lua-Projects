-- BEGIN_IMPORT
-- import Raids.modules.Events.EventTable end
-- import Raids.modules.Events.EventItem end
-- import Raids.classes.Player end
-- END_IMPORT

GREED_TABLE = nil
NEED_TABLE = nil

LOOT_TABLE = {
    gordius = {
        1 = 'mightofgordius'
        2 = 'shardofgordius'
        3 = 'mightofgordius'
        4 = 'shardofgordius'
        5 = 'mightofgordius'
        6 = 'shardofgordius'
    }
}

function rewardLoot(bossName)
    math.randomseed(os.time())
    local number = math.random(6)
    local item = LOOT_TABLE[bossName][number]
    --queue up roll event
    GREED_TABLE = {}
    NEED_TABLE = {}
    rollEvent = EventItem:new()
    rollEvent:set(nil, nil, function() end, 30 * 30)
    
end