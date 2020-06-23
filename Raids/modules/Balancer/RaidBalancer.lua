-- BEGIN_IMPORT
-- import Raids.globals.values end
-- END_IMPORT

function Balancer()
    local numberOfPlayers = 0
    for k,v in pairs(ACTIVE_PLAYER_LIST) do
        numberOfPlayers = numberOfPlayers + 1
    end
    local XSM_MIN = 0
    local XSM_MAX = 4
    local SM_MIN = 5
    local SM_MAX = 6
    local MED_MIN = 7
    local MED_MAX = 11
    local LG_MIN = 12
    local LG_MAX = 13
    local XLG_MIN = 14
    local XLG_MAX = 16
    if numberOfPlayers >= XSM_MIN and numberOfPlayers <= XSM_MAX then
        say_all("New Raid Size: Xtra Small")
        NUMBER_OF_ALLOWED_TANKS = 1
        NUMBER_OF_ALLOWED_HEALERS = 1
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 1.0
    elseif numberOfPlayers >= SM_MIN and numberOfPlayers <= SM_MAX then
        say_all("New Raid Size: Small")
        NUMBER_OF_ALLOWED_TANKS = 1
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 1.5
    elseif numberOfPlayers >= MED_MIN and numberOfPlayers <= MED_MAX then
        say_all("New Raid Size: Medium")
        NUMBER_OF_ALLOWED_TANKS = 1
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 2.5
    elseif numberOfPlayers >= LG_MIN and numberOfPlayers <= LG_MAX then
        say_all("New Raid Size: Large")
        NUMBER_OF_ALLOWED_TANKS = 2
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 1
        BOSS_MULTIPLIER = 3.75
    elseif numberOfPlayers >= XLG_MIN and numberOfPlayers <= XLG_MAX then
        say_all("New Raid Size: Xtra Large")
        NUMBER_OF_ALLOWED_TANKS = 2
        NUMBER_OF_ALLOWED_HEALERS = 2
        NUMBER_OF_ALLOWED_BANDOLIERS = 2
        BOSS_MULTIPLIER = 5.0
    end
end

function numberOfPlayersWithClass(class)
    local numberOfPlayers = 0
    for key,_ in pairs(ACTIVE_PLAYER_LIST) do
        if ACTIVE_PLAYER_LIST[key]:getClass():getClassName() == class then
            numberOfPlayers = numberOfPlayers + 1
        end
    end
    return numberOfPlayers
end