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
        elseif args[1] == "equip" then
            if args[2] ~= nil then
                player:setEquipment(args[2]) 
            else
                say(playerIndex, "You need to specify the equipment you want to equip!")
            end
            return true
        elseif args[1] == "loadout" then
           if player:setLoadout(nil, args[2], args[3]) then
                kill(playerIndex)
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
        elseif args[1] == "sound" then
            say_all("Spawning sound!")
            local weap = spawn_object("weap", "zteam\\objects\\weapons\\single\\battle_rifle\\h3\\piercer", 102.23, 417.59, 5)
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
        elseif args[1] == "whoami" then
            say(playerIndex, "You are a " .. displayProperClassName(player:getClass():getClassName()))
            return true
        elseif args[1] == "moreinfo" then
            if ITEM_LIST[args[2]] ~= nil then
                say(playerIndex, "=======================================")
                if ITEM_LIST[args[2]].type then say(playerIndex, "Type: " .. ITEM_LIST[args[2]].type) end
                if ITEM_LIST[args[2]].description then say(playerIndex, "Description: " .. ITEM_LIST[args[2]].description) end
                if ITEM_LIST[args[2]].defense then say(playerIndex, "Defense: " .. ITEM_LIST[args[2]].defense) end
                if ITEM_LIST[args[2]].maxHealth then say(playerIndex, "Health: " .. ITEM_LIST[args[2]].maxHealth) end
                say(playerIndex, "=======================================")
            else
                say(playerIndex, "That item does not exist!")
            end
            return true
        --TODO: Index the want and need rolls based on player
        --TODO: Add class checks on roll commands in future
        elseif args[1] == "greed" then
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