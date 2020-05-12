api_version = "1.12.0.0"

--Implement any global modules, tables, or values in this file or within this directory.

BIPEDS = {
    ["default"] = "dreamweb\\characters\\odst\\s09_custom\\_test\\test",
	["elite"] = "cmt\\characters\\evolved_h1-spirit\\elite\\bipeds\\elite_combat_major",
}

--Implement any utility / interfacing function within this file, or in this directory.

function FindBipedTag(TagName)
    local tag_array = read_dword(0x40440000)
    for i=0,read_word(0x4044000C)-1 do
        local tag = tag_array + i * 0x20
        if(read_dword(tag) == 1651077220 and read_string(read_dword(tag + 0x10)) == TagName) then
            return read_dword(tag + 0xC)
        end
    end
end

--Modules.
--You can implement any modules or components that you will need, within this file or within this directory.

--Implement your callbacks in here.
--You can also implement them in separate files, within the callback directory.



function OnCommand(PlayerIndex,Command,Environment,Password)
    if(player_present(PlayerIndex)) then
        Command = string.lower(Command)
        commandargs = {}
        for w in Command:gmatch("%S+") do commandargs[#commandargs + 1] = w end
        if(commandargs[1] == "armor") then
            if(#commandargs == 1) then
                say(PlayerIndex,"Use /armor followed by the armor you wanted")
            elseif(#commandargs > 1) then
                armorwanted = Command:sub(commandargs[1]:len() + 2)
                if(BIPEDS[armorwanted] == nil) then
                    say(PlayerIndex,"Armor " .. armorwanted .. " does not exist.")
                else
                    CHOSEN_BIPEDS[get_var(PlayerIndex,"$hash")] = armorwanted
                    say(PlayerIndex,"You will respawn with " .. armorwanted .. " armor.")
                end
            end
            return false
        end
    end
    return true
end

function OnObjectSpawn(PlayerIndex, MapID, ParentID, ObjectID)
    if(player_present(PlayerIndex) == false) then return true end
    if(DEFAULT_BIPED == nil) then
        local tag_array = read_dword(0x40440000)
        for i=0,read_word(0x4044000C)-1 do
            local tag = tag_array + i * 0x20
            if(read_dword(tag) == 1835103335 and read_string(read_dword(tag + 0x10)) == "globals\\globals") then
                local tag_data = read_dword(tag + 0x14)
                local mp_info = read_dword(tag_data + 0x164 + 4)
                for j=0,read_dword(tag_data + 0x164)-1 do
                    DEFAULT_BIPED = read_dword(mp_info + j * 160 + 0x10 + 0xC)
                end
            end
        end
    end
    local hash = get_var(PlayerIndex,"$hash")
    if(MapID == DEFAULT_BIPED and CHOSEN_BIPEDS[hash]) then
        for key,value in pairs(BIPEDS) do
            if(BIPED_IDS[key] == nil) then
                BIPED_IDS[key] = FindBipedTag(BIPEDS[key])
            end
        end
        return true,BIPED_IDS[CHOSEN_BIPEDS[hash]]
    end
    return true
end

--Main.
--Define your callbacks here, and do your clean up in here.

function OnScriptLoad()
    register_callback(cb['EVENT_OBJECT_SPAWN'],"OnObjectSpawn")
    register_callback(cb['EVENT_GAME_END'],"OnGameEnd")
    register_callback(cb['EVENT_COMMAND'],"OnCommand")
end

function OnScriptUnload()
end

function OnError(message)
    print(message)
end

OnGameEnd = OnScriptUnload

--End of build file.