-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.classes.Player end
-- import Raids.classes.Boss end
-- import Raids.sapp.PlayerEvents.ActivateUltimateAbility end
-- import Raids.sapp.PlayerEvents.Commands.ChangePlayerClass end
-- END_IMPORT

function parseCommand(playerIndex, command)
    args = {} 
    local hash = get_var(playerIndex, "$hash")
    for w in command:gmatch("%w+") do args[#args+1] = w end
        if args[1] == "class" then 
            if args[2] == "boss" and tonumber(get_var(playerIndex, "$lvl")) ~= 4 then
                say(playerIndex, "You must be an admin to become a boss!")
            else
                changePlayerClass(playerIndex, args[2])
            end
            return true
        elseif args[1] == "ult" or args[1] == "ultimate" then
            if ACTIVE_PLAYER_LIST[hash]:getClass().boss == nil then
                activateUltimateAbility(hash, playerIndex)
            else
                say(playerIndex, "Bosses cannot do that!")
            end
            return true
        elseif args[1] == "sp" then
            spawn_object("weap", "halo reach\\objects\\weapons\\support_high\\spartan_laser\\savant", 105.62, 342.36, -3)
            return true
        elseif args[1] == "boss" then
            if tonumber(get_var(playerIndex, "$lvl")) == 4 and ACTIVE_PLAYER_LIST[hash]:getClass().boss ~= nil then
                if BIPED_TAG_LIST[args[2]] ~= nil then
                    kill(playerIndex)
                    local playerClass = ACTIVE_PLAYER_LIST[hash]:getClass()
                    playerClass:changeBoss(args[2])
                else
                    say(playerIndex, "That boss does not exist!")
                end
                return true
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