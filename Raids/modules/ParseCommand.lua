-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.util.PlayerEvents end
-- END_IMPORT

function parseCommand(playerIndex, command)
    args = {} 
    local hash = get_var(playerIndex, "$hash")
    for w in command:gmatch("%w+") do args[#args+1] = w end
        if args[1] == "class" then 
            if CLASS_LIST[args[2]] ~= nil then
                changePlayerClass(playerIndex, args[2])
            else
                say(playerIndex, "That class does not exist!")
            end
            return true
        elseif args[1] == "ultimate" then
            if ACTIVE_PLAYER_LIST[hash]:getClass().cooldown == false then
                ACTIVE_PLAYER_LIST[hash]:getClass():ultimate(playerIndex)
            else
                say(playerIndex, "This ability is on cooldown!")
            end
            return true
        elseif args[1] == "whoami" then
            say(playerIndex, "You are a " .. ACTIVE_PLAYER_LIST[hash]:getClass().name)
            return true
        end
        return false
end