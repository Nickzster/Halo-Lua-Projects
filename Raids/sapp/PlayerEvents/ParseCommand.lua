-- BEGIN_IMPORT
-- import Raids.globals.values end
-- import Raids.globals.RaidItems end
-- import Raids.classes.Player end
-- import Raids.classes.Boss end
-- import Raids.sapp.PlayerEvents.ActivateUltimateAbility end
-- import Raids.sapp.PlayerEvents.Commands.ChangePlayerClass end
-- import Raids.sapp.PlayerEvents.Commands.ChangeBoss end
-- import Raids.gameplay.Reward.Loot end
-- import Raids.util.ProperClassNames end
-- import Raids.modules.Events.EventTable end
-- import Raids.modules.Events.EventItem end
-- import Raids.gameplay.BossEvents.PlaySound end
-- import Raids.globals.Dialog end
-- import Raids.util.ViewItem end
-- END_IMPORT

function parseCommand(playerIndex, command)
    if player_present(playerIndex) and player_alive(playerIndex) then
        args = {} 
        local hash = get_var(playerIndex, "$hash")
        local player = ACTIVE_PLAYER_LIST[hash]
        for w in command:lower():gmatch("%w+") do 
            args[#args+1] = w 
        end
        if args[1] == "class" then 
            if #ACTIVE_BOSSES == 0 then
                if args[2] == "boss" and tonumber(get_var(playerIndex, "$lvl")) ~= 4 then
                    say(playerIndex, "You must be an admin to become a boss!")
                else
                    changePlayerClass(playerIndex, parseProperClassName(args[2]))
                end
            else
                say(playerIndex, "You cannot change your class during a boss event!")
            end
            return true
        elseif args[1] == "ult" or args[1] == "ultimate" then
            if player:getClass():getClassName() ~= "boss" then
                activateUltimateAbility(hash, playerIndex)
            else
                say(playerIndex, "Bosses cannot do that!")
            end
            return true
        elseif args[1] == "save" then
            player:savePlayer()
            return true
        elseif args[1] == "equip" then
            if args[2] ~= nil then
                player:setEquipment(args[2]) 
            else
                say(playerIndex, "You need to specify the equipment you want to equip!")
            end
            return true
        elseif args[1] == "equipment" then
            say(playerIndex, player:getEquipment():getName())
            return true
        elseif args[1] == "armor" then
            if #ACTIVE_BOSSES == 0 then
                if player:setArmor(nil, args[2]) then
                    kill(playerIndex)
                end
            else
                say(playerIndex, "You cannot change your armor during a boss event!")
            end
            return true
        elseif args[1] == "reward" then
            if tonumber(get_var(playerIndex, "$lvl")) ~= 4 then say("You need admin priviledges to execute this!") return true end
            if args[2] == nil then say(playerIndex, "You need to specify a player index!") return true end
            if args[3] == nil then say(playerIndex, "You need to specify a reward item!") return true end
            if ITEM_LIST[args[3]] == nil then say(playerIndex, "You need to specify a valid item!") return true end
            if player_present(tonumber(args[2])) == false then say(playerIndex, "You need to specify a present player!") return true end
            local targetPlayerHash = get_var(tonumber(args[2]), "$hash")
            ACTIVE_PLAYER_LIST[targetPlayerHash]:addItemToInventory(args[3])
            return true
        elseif args[1] == "remove" then
            if tonumber(get_var(playerIndex, "$lvl")) ~= 4 then say("You need admin priviledges to execute this!") return true end
            if args[2] == nil then say(playerIndex, "You need to specify a player index!") return true end
            if args[3] == nil then say(playerIndex, "You need to speicify an item to remove!") return true end
            if player_present(tonumber(args[2])) == false then say(playerIndex, "You need to specify a present player!") return true end
            local targetPlayerHash = get_var(tonumber(args[2]), "$hash")
            ACTIVE_PLAYER_LIST[targetPlayerHash]:removeItemFromInventory(args[3])
            return true
        elseif args[1] == "respawn" then
            if #ACTIVE_BOSSES == 0 then
                kill(playerIndex)
            else
                say(playerIndex, "You cannot respawn during a boss event!")
            end
            return true
        elseif args[1] == "loadout" then
            if #ACTIVE_BOSSES == 0 then
                if player:setLoadout(nil, args[2], args[3]) then
                        kill(playerIndex)
                end
            else 
                say(playerIndex, "You cannot change your loadout during a boss event!")
            end
           return true
        elseif args[1] == "test" then
            -- Note: get_dynamic_player(playerIndex) is equivalent to m_player or m_object or m_unit
            local playerCurrentWeap = read_word(get_dynamic_player(playerIndex) + 0x2F2)
            if playerCurrentWeap == nil or playerCurrentWeap == 0 then
                say(playerIndex, "Operation failed!")
            else
                say(playerIndex, "The value is: " .. playerCurrentWeap)
            end
            return true
        elseif args[1] == "spawn" then
            local weapon = args[2]
            if tonumber(get_var(playerIndex, "$lvl")) ~= 4 then
                say(playerIndex, "You must be an admin to execute this command!")
            elseif weapon == nil 
            or ITEM_LIST[weapon] == nil
            or ITEM_LIST[weapon].type ~= "WEAPON" 
            or ITEM_LIST[weapon].ref == nil 
            then 
                say(playerIndex, "This item does not exist") 
            else 
                spawn_object("weap", ITEM_LIST[weapon].ref, 105.62, 342.36, -3)
            end
            return true
        elseif args[1] == "boss" then
            if tonumber(get_var(playerIndex, "$lvl")) == 4 and player:getClass():getClassName() == "boss" then
                changeBoss(playerIndex, player, args[2])
            else
                say(playerIndex, "You cannot do that!")
            end
            return true
        elseif args[1] == "wipe" then
            if player:getClass():getClassName() ~= "boss" then say(playerIndex, "You cannot execute this command!") return true end
            local boss = player:getArmor(nil):getName()
            player:setArmor(nil, "DEFAULT")
            for i=0,16 do
                if player_present(i) then
                    kill(i)
                end
            end
            kill(playerIndex)
            playDialog(boss, "wipe")
            return true
        elseif args[1] == "whoami" then
            say(playerIndex, "You are a " .. displayProperClassName(player:getClass():getClassName()))
            return true
        elseif args[1] == "moreinfo" or args[1] == "more" then
            if ITEM_LIST[args[2]] ~= nil then
                ViewItem(ITEM_LIST[args[2]], playerIndex)
            else
                say(playerIndex, "That item does not exist!")
            end
            return true
        elseif args[1] == "own" then
            if ITEM_LIST[args[2]] == nil then say(playerIndex, "This is not a valid item!") return true end
            if player:checkForItem(args[2]) then say(playerIndex, "You have item: " .. ITEM_LIST[args[2]].pretty)
            else say(playerIndex, "You do not have item: " .. ITEM_LIST[args[2]].pretty)
            end   
            return true
        elseif args[1] == "greed" then
            --TODO: Index the want and need rolls based on player
            --TODO: Add class checks on roll commands in future
            if GREED_TABLE ~= nil and GREED_TABLE[playerIndex] == nil and NEED_TABLE[playerIndex] == nil then
                math.randomseed(os.time())
                local lootRoll = math.random(100)
                table.insert(GREED_TABLE, {
                    player=playerIndex,
                    roll=lootRoll
                })
                say_all(get_var(playerIndex, "$name") .. " has selected greed, and rolls a " .. lootRoll)
            else
                say(playerIndex, "You can't roll right now!")
            end
            return true
        elseif args[1] == "need" then
            if NEED_TABLE ~= nil and NEED_TABLE[playerIndex] == nil and GREED_TABLE[playerIndex] == nil then
                math.randomseed(os.time())
                local lootRoll = math.random(100)
                table.insert(NEED_TABLE, {
                    player=playerIndex,
                    roll=lootRoll
                })
                say_all(get_var(playerIndex, "$name") .. " has selected need, and rolls a " .. lootRoll)
            else
                say(playerIndex, "You can't roll right now!")
            end
            return true
        end
        return false
    end
end