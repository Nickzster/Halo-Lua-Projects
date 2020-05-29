-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Player end
-- import Raids.classes.Boss end
-- import Raids.sapp.PlayerEvents.ActivateUltimateAbility end
-- import Raids.sapp.PlayerEvents.Commands.ChangePlayerClass end
-- import Raids.sapp.PlayerEvents.Commands.ChangeBoss end
-- END_IMPORT

function parseCommand(playerIndex, command)
    args = {} 
    local hash = get_var(playerIndex, "$hash")
    local player = ACTIVE_PLAYER_LIST[hash]
    for w in command:gmatch("%w+") do args[#args+1] = w end
        if args[1] == "class" then 
            if args[2] == "boss" and tonumber(get_var(playerIndex, "$lvl")) ~= 4 then
                say(playerIndex, "You must be an admin to become a boss!")
            else
                changePlayerClass(playerIndex, args[2])
            end
            return true
        elseif args[1] == "ult" or args[1] == "ultimate" then
            if player:getClass().boss == nil then
                activateUltimateAbility(hash, playerIndex)
            else
                say(playerIndex, "Bosses cannot do that!")
            end
            return true
        elseif args[1] == "sp" then
            say_all("Spawning sound!")
            local weap = spawn_object("weap", "zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer", 102.23, 417.59, 5)
            assign_weapon(weap, tonumber(playerIndex))
            return true
        elseif args[1] == "test" then
            player:addInventoryItem("armor_piercing")
            return true
        elseif args[1] == "boss" then
            if tonumber(get_var(playerIndex, "$lvl")) == 4 and player:getClass().boss ~= nil then
                changeBoss(playerIndex, player, args[2])
            else
                say(playerIndex, "You cannot do that!")
            end
            return true
        elseif args[1] == "whoami" then
            say(playerIndex, "You are a " .. ACTIVE_PLAYER_LIST[hash]:getClass().name)
            return true
        end
        return false
end