-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Player end
-- import Raids.sapp.PlayerEvents.ActivateUltimateAbility end
-- import Raids.sapp.PlayerEvents.Commands.ChangePlayerClass end
-- END_IMPORT

function parseCommand(playerIndex, command)
    args = {} 
    local hash = get_var(playerIndex, "$hash")
    for w in command:gmatch("%w+") do args[#args+1] = w end
        if args[1] == "class" then 
            changePlayerClass(playerIndex, args[2])
            return true
        elseif args[1] == "ultimate" then
            activateUltimateAbility(hash, playerIndex)
            return true
        elseif args[1] == "whoami" then
            say(playerIndex, "You are a " .. ACTIVE_PLAYER_LIST[hash]:getClass().name)
            return true
        end
        return false
end