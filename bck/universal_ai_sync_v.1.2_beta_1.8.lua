
-- Universal AI synchronization server script V.1.2 (Release/BETA 1.7, compatible with client GAMMA and DELTA versions), by IceCrow14.

-- Text tags for important stuff: "TESTING", "PENDING", "REMINDER", "DEBUGGED".

-- BETA 1.7 introduces a settings file for more customization, compression methods, and support for encounter-free bipeds, just like the client. For a more detailed list of the changes from the last version, look up the client script.

api_version = "1.11.1.0"

-- Globals (and default values)
settings = nil
map_is_ready = nil
debug_level = 4 -- Available values: 0 (No messages, silent) to 4 (Everything except RCON update packets, is printed to console).
updater_period = 1000/4
biped_indexer_period = 3000
print_biped_count_period = 10000 -- PENDING: Currently not affected by the file setting. To set a new value write it here.
server_side_projectiles = true
char_table = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", 
			  "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
			  "w", "x", "y", "z", "A", "B", "C", "D", "E"} -- There's some funny math behind this...

-- Object/data tables
biped_paths = {}
biped_lists = {}
weapon_paths = {}
objects = {}
undesired_objects = {}
bipeds = {}
dead_bipeds = {}
deleted_bipeds = {}

function OnScriptLoad()
	register_callback(cb['EVENT_OBJECT_SPAWN'],'OnObjectSpawn') -- Callbacks
	register_callback(cb['EVENT_GAME_START'],'OnGameStart')
	register_callback(cb['EVENT_GAME_END'],'OnGameEnd')
	FindOrCreateSettings() -- Global timers and functions
	timer(print_biped_count_period, "PrintBipedCounts", 1)
end

function OnScriptUnload()
	settings = nil
	map_is_ready = nil
	debug_level = nil
	updater_period = nil
	biped_indexer_period = nil
	print_biped_count_period = nil
	server_side_projectiles = nil
	biped_paths = nil
	biped_lists = nil
	weapon_paths = nil
	objects = nil
	undesired_objects = nil
	bipeds = nil
	dead_bipeds = nil
	deleted_bipeds = nil
end

function OnGameStart()
	biped_paths = {}
	biped_lists = {}
	weapon_paths = {}
	bipeds = {}
	dead_bipeds = {}
	deleted_bipeds = {}
	ReadSettings()
	if map_is_ready ~= -1 then
		TagManipulationServer(GetScenarioPath())
		DebugConsolePrint("Tag manipulation stage finished.", 1, 0xA)
		map_is_ready = 1
		BipedIndexer()
		timer(biped_indexer_period, "BipedIndexer")
		timer(updater_period, "Updater", 1) -- Instance #1.
		timer(updater_period/2, "UpdaterStarter", 2) -- Instance #2.
	end
end

function OnGameEnd()
	map_is_ready = 0
	objects = {} -- Some objects will not be present if this table is cleared in "OnGameStart".
	undesired_objects = {}
end

function OnObjectSpawn(PlayerIndex, TagID, ParentObjectID, NewObjectID, SappSpawning)
	table.insert(objects,NewObjectID)
end

-- >>> Sub-level functions: Used by the functions above. <<<

-- FILE I/O FUNCTIONS

-- For the settings file. Only executed after "OnScriptLoad" and "OnGameStart" callbacks. Each function comes with its own sub-level ID.

function FindOrCreateSettings() -- S.L. 1.
	settings = io.open("uais_settings_server.txt", "r")
	DebugConsolePrint("Reading AI synchronization settings...", 1, 0xB)
	if settings == nil then
		DebugConsolePrint("File not found. Creating settings...", 1, 0xB)
		settings = io.open("uais_settings_server.txt", "w")
		io.output(settings)
		io.write("@ You can specify new values for the following settings manually as long as you don't modify the format or specify invalid ones. To add a new excluded map, just write its file name (without the .map extension) below the EXCLUDED MAPS section, specify only one map per line.\n")
		io.write("@ If for some reason you break the file (GG), just delete it, restart your dedicated server and the script will create a new one automatically for you. For questions or help, you can find me on YouTube or Discord. -IceCrow14\n")
		io.write("@\n@ Updates per second for a single biped.\n")
		io.write("UPDATES PER SECOND\n4\n")
		io.write("BIPED INDEXER PERIOD (ms)\n3000\n")
		io.write("PRINT BIPED COUNT PERIOD (ms, currently unused)\n10000\n")
		io.write("SERVER SIDE PROJECTILES (true/false)\ntrue\n")
		io.write("DEBUG LEVEL (0 - 4)\n1\n")
		io.write("EXCLUDED MAPS\n") -- Stock maps will be added by default.
		io.write("beavercreek\nsidewinder\ndamnation\nratrace\nprisoner\nhangemhigh\nchillout\ncarousel\nboardingaction\nbloodgulch\nwizard\nputput\nlongest\nicefields\ndeathisland\ndangercanyon\ninfinity\ntimberland\ngephyrophobia\n")
		io.close(settings)
		DebugConsolePrint("Settings created.", 1, 0xB)
		settings = io.open("uais_settings_server.txt", "r")
	end
	io.close(settings)
	DebugConsolePrint("Settings file closed.", 1, 0xB)
end

function ReadSettings()
	local current_map = get_var(9, "$map")
	local valid_map = true
	local lines = {}
	local updates_per_second
	settings = io.open("uais_settings_server.txt", "r")
	io.input(settings)
	for line in settings:lines() do
		if not string.match(line, "@") then
			table.insert(lines, line)
		end
	end
	updates_per_second = tonumber(lines[2])
	biped_indexer_period = tonumber(lines[4])
	print_biped_count_period = tonumber(lines[6]) -- REMINDER: Unused.
	if lines[8] == "true" then
		server_side_projectiles = true
	elseif lines[8] == "false" then
		server_side_projectiles = false
	end
	debug_level = tonumber(lines[10])
	DebugConsolePrint("UPS: "..updates_per_second..", BIP: "..biped_indexer_period..", PBCP: "..print_biped_count_period..", SSP: "..tostring(server_side_projectiles)..", DL: "..debug_level..", EMS: "..(#lines - 11), 1, 0xA)
	updater_period = 1000/updates_per_second
	for map = 12, #lines do
		if lines[map] == current_map then
			valid_map = false
			DebugConsolePrint("WARNING: Excluded map identified ("..current_map.."). AI will not synchronize.", 1, 0xE)
			break
		end
	end
	io.close(settings)
	if valid_map == false then
		map_is_ready = -1
	end
	DebugConsolePrint("ReadSettings() finished.", 1, 0xB)
end

-- REMOTE CONSOLE & UPDATER FUNCTIONS

-- Used to read, prepare and communicate the information to the clients.

function BipedIndexer() -- S.L. 1.
	if map_is_ready == 1 then
		for i = 1, #objects do
			if undesired_objects[i] ~= true then
				local object_id = objects[i]
				local object_address = get_object_memory(object_id)
				if object_address ~= 0 then
					if read_word(object_address + 0xB4) == 0 then
						local object_player_id = read_dword(object_address + 0xC0)
						local object_health = read_float(object_address + 0xE0)
						local object_dead_bit = read_bit(object_address + 0x106, 2)
						if object_player_id == 0xFFFFFFFF and object_health > 0 and object_dead_bit == 0 then -- Detect if this biped is a player, if it isn't, continue.
							local stored_in_bipeds = false
							for j = 1,#bipeds do
								if object_id == bipeds[j] then
									stored_in_bipeds = true
								end
							end
							if stored_in_bipeds == false then -- Add to a table. 
								table.insert(bipeds, object_id)
								local stored_in_biped_lists = false
								for k = 1,#biped_lists do
									local c_biped_list = biped_lists[k]
									for l = 1,#bipeds do
										local c_biped_object_id = c_biped_list[l]
										if object_id == c_biped_object_id then
											stored_in_biped_lists = true
											break
										end
									end
								end
								if stored_in_biped_lists == false then
									local biped_tag_id = read_dword(object_address)
									local biped_was_added_to_list = false
									for k = 1,#biped_paths do
										local c_biped_path = biped_paths[k]
										local c_biped_path_tag_address = lookup_tag("bipd", c_biped_path)
										local c_biped_path_tag_id = read_dword(c_biped_path_tag_address + 0xC)
										if biped_tag_id == c_biped_path_tag_id then -- Add biped object ID with this index from the bipeds table, to this biped table from the biped_lists table, then break. Oof.
											local biped_list = biped_lists[k]
											biped_list[#bipeds] = object_id
											biped_was_added_to_list = true
											DebugConsolePrint("Successfully added a #"..k, 3, 0x2)
											break
										end
									end
									if biped_was_added_to_list == false then
										DebugConsolePrint("WARNING: The biped "..#bipeds.." wasn't added to any biped table (Tag path may not match with any from the 'biped_paths' list)", 1, 0xE) -- This shouldn't happen anymore.
									end
								end
							end
						end
					else
						undesired_objects[i] = true -- To avoid unnecessary evaluations.
					end
				else
					undesired_objects[i] = true
				end
			end
		end
		DebugConsolePrint("Biped Indexer()", 2, 0xB)
		return true
	else
		return false
	end
end

function PrintBipedCounts(PrintToChat)
	if map_is_ready == 1 then
		local bipeds_alive = 0
		local bipeds_dead = 0
		local bipeds_deleted = 0
		local final_message
		for i = 1,#bipeds do
			if bipeds[i] ~= nil then
				if dead_bipeds[i] ~= nil then
					if deleted_bipeds[i] ~= nil then
						bipeds_deleted = bipeds_deleted + 1
					else
						bipeds_dead = bipeds_dead + 1
					end
				else
					bipeds_alive = bipeds_alive + 1
				end
			end
		end
		final_message = bipeds_alive.." bipeds alive, "..bipeds_dead.." dead, "..bipeds_deleted.." deleted."
		DebugConsolePrint(final_message, 1, 0x3)
		if PrintToChat == "1" then
			say_all(final_message)
		end
	end
	return true
end

function UpdaterStarter(Instance) -- Creates a delayed timer used to start another instance of the 'Updater' function, for optimization purposes.
	timer(updater_period, "Updater", Instance)
	return false
end

function Updater(Instance) -- S.L. 2 (1 & 2).
	if map_is_ready == 1 then
		if #bipeds > 0 then
			local instance = tonumber(Instance) -- Timer arguments are passed as strings.
			local updater_limits = GetUpdaterLimits(instance)
			for i = updater_limits[1], updater_limits[2] do
				if bipeds[i] ~= nil then
					local biped_address = get_object_memory(bipeds[i])
					if biped_address ~= 0 then -- Both, dead and alive bipeds are updated as long as they exist.
						if (read_float(biped_address + 0xE0) <= 0) and (read_bit(biped_address + 0x106, 2) == 1) then -- 'Health' == 0 and 'Health is empty' == 1. 
							if dead_bipeds[i] == nil then
								dead_bipeds[i] = true
								DebugConsolePrint("Biped #"..i.." killed", 3, 0x2)
							end
						end
						for j = 1,#biped_lists do
							local biped_list = biped_lists[j]
							if biped_list[i] ~= nil then
								RCONUpdateBiped(i, j, biped_address)
							end
						end
					else
						if dead_bipeds[i] == true then
							if deleted_bipeds[i] == nil then
								deleted_bipeds[i] = true
								DebugConsolePrint("Biped #"..i.." deleted", 3, 0x2)
								RCONDeleteBipedStarter(i)
							end
						else
							if dead_bipeds[i] == nil then -- Deleted through commands or unknown causes.
								dead_bipeds[i] = true
							end
						end
					end
				end
			end
		end
		DebugConsolePrint("Updater()", 4, 0xB)
		return true
	else
		return false
	end
end

function GetUpdaterLimits(Instance) -- S.L. 3.
	local updater_instances = 2 -- REMINDER: Don't touch this unless you have added/removed another instance manually.
	local total_bipeds = #bipeds
	while (total_bipeds % updater_instances) ~= 0 do
		total_bipeds = total_bipeds + 1
	end
	local upper_limit = (total_bipeds/updater_instances) * Instance
	local lower_limit = (total_bipeds/updater_instances) * (Instance - 1) + 1
	local limits = {lower_limit, upper_limit}
	return limits
end

function RCONUpdateBiped(Index, BipedListIndex, BipedAddress)
	local biped_address = BipedAddress
	local biped_index = Word16ToHex4(Index) -- Max: 65535
	local biped_list_index = Byte8ToHex2(BipedListIndex)
	local weapon_list_index = Byte8ToHex2(GetBipedWeaponType(Index))
	local x = ReadFloat32ToChar3(biped_address + 0x5C)
	local y = ReadFloat32ToChar3(biped_address + 0x60)
	local z = ReadFloat32ToChar3(biped_address + 0x64)
	local x_vel = ReadFloat32ToChar3(biped_address + 0x68)
	local y_vel = ReadFloat32ToChar3(biped_address + 0x6C)
	local z_vel = ReadFloat32ToChar3(biped_address + 0x70)
	local pitch = ReadFloat32ToChar3(biped_address + 0x74)
	local yaw = ReadFloat32ToChar3(biped_address + 0x78) -- Roll not used by bipeds.
	local pitch_vel = ReadFloat32ToChar3(biped_address + 0x8C)
	local yaw_vel = ReadFloat32ToChar3(biped_address + 0x90)
	local x_aim = ReadFloat32ToChar3(biped_address + 0x23C)
	local y_aim = ReadFloat32ToChar3(biped_address + 0x240)
	local z_aim = ReadFloat32ToChar3(biped_address + 0x244)
	local x_aim_vel = ReadFloat32ToChar3(biped_address + 0x248)
	local y_aim_vel = ReadFloat32ToChar3(biped_address + 0x24C)
	local z_aim_vel = ReadFloat32ToChar3(biped_address + 0x250)
	local animation = ReadWord16ToHex4(biped_address + 0xD0)
	local local_health = read_float(biped_address + 0xE0)
	local local_shield = read_float(biped_address + 0xE4)
	local local_health_empty = read_bit(biped_address + 0x106, 2)
	local local_shield_empty = read_bit(biped_address + 0x106, 3)
	local health_state = BipedStateBoolean(local_health, local_health_empty)
	local shield_state = BipedStateBoolean(local_shield, local_shield_empty)
	local rcon_message = "@bu"..x..y..z..x_vel..y_vel..z_vel..pitch..yaw..pitch_vel..yaw_vel..x_aim..y_aim..z_aim..x_aim_vel..y_aim_vel..z_aim_vel..biped_index..animation..biped_list_index..weapon_list_index..health_state..shield_state
	for player = 1, 16 do
		rprint(player, rcon_message)
	end
	-- DebugConsolePrint(rcon_message, 5, 0x2)
end

function RCONDeleteBipedStarter(BipedIndex)
	local attempts = 3 -- These can be changed safely, but I recommend leaving them untouched.
	local delay = 3000
	for j = 1, attempts do
		local c_attempt_delay = (j - 1) * delay
		for player = 1, 16 do
			timer(c_attempt_delay, "RCONDeleteBiped", BipedIndex, player)
		end
	end
end

function RCONDeleteBiped(BipedIndex, PlayerIndex) -- S.L. 4.
	local biped_index = Word16ToHex4(tonumber(BipedIndex))
	local player_index = tonumber(PlayerIndex)
	rprint(player_index, "@bd"..biped_index)
	return false
end

-- GENERIC/MISCELLANEOUS FUNCTIONS

-- Functions that wouldn't fit anywhere else.

function DebugConsolePrint(String, MessageDebugLevel, Color) -- S.L. 4 (1, 2, 3 & 4).
	if MessageDebugLevel <= debug_level then -- Lower value, higher hierarchy (and less messages).
		if Color ~= nil and Color < 0x10 and Color > -1 then
			cprint(String, Color)
		else
			cprint(String)
		end
	end
end

function GetBipedWeaponType(BipedIndex) -- S.L. 4.
	local biped_address = get_object_memory(bipeds[BipedIndex])
	local weapon_object_id = read_dword(biped_address + 0x118)
	local weapon_type_ready = false
	if weapon_object_id ~= 0xFFFFFFFF then
		local weapon_address = get_object_memory(weapon_object_id)
		local weapon_tag_id = read_dword(weapon_address)
		for j = 1,#weapon_paths do
			local c_weapon_tag_address = lookup_tag("weap", weapon_paths[j])
			local c_weapon_tag_id = read_dword(c_weapon_tag_address + 0xC)
			if c_weapon_tag_id == weapon_tag_id then
				weapon_type_ready = true
				return j
			end
		end
		if weapon_type_ready == false then
			return 0 -- In case the weapon type hasn't been declared yet.
		end
	else
		return 0 -- The biped is unarmed.
	end
end

-- DATA COMPRESSION FUNCTIONS

-- Self explanatory. Most of these functions consist of reducing the amount of text characters necessary to represent numbers on the client-side using conversions between numeral systems (B, D, H, 41).

function ReadFloat32ToHex4(Address) -- S.L. 4. Unused. Optimized, because the previous one was ridiculously inefficient.
	if Address ~= 0 then
		local binary32_exponent = {} -- Read from memory.
		local binary16
		local binary16_sign
		local binary16_exponent
		local binary16_mantissa = {}
		local hex = {}
		local offset = 3
		for i = 0, 18 do
			local c_bit_address = Address + offset
			local c_bit_index = 7 - i + 8 * (3 - offset)
			local c_bit = read_bit(c_bit_address, c_bit_index)
			if i == 0 then
				binary16_sign = c_bit
			elseif i > 0 and i < 9 then
				table.insert(binary32_exponent, c_bit)
			else
				table.insert(binary16_mantissa, c_bit)
			end
			if (i + 1) % 8 == 0 then
				offset = offset - 1
			end
		end
		binary16_mantissa = table.concat(binary16_mantissa) -- 32 bit binary to 16 bit binary.
		local binary16_exponent = tonumber(table.concat(binary32_exponent), 2) - 127 + 15
		if binary16_exponent > 31 then
			binary16_exponent = 31
		elseif binary16_exponent < 0 then
			binary16_exponent = 0
		end
		binary16_exponent = DecimalToBinary(binary16_exponent, 5)
		binary16 = binary16_sign..binary16_exponent..binary16_mantissa
		for i = 1, 4 do -- Binary to hex.
			local c_hex = string.format("%X", tonumber(string.sub(binary16, (i - 1) * 4 + 1, i * 4), 2 )) -- This hurts...
			table.insert(hex, c_hex)
		end
		hex = table.concat(hex)
		return hex
	else
		return "0000"
	end
end

function ReadWord16ToHex4(Address)
	if Address ~= nil then
		local binary = {}
		local hex = {}
		local offset = 1
		for i = 0, 15 do
			local c_bit_address = Address + offset
			local c_bit_index = 7 - i + 8 * (1 - offset)
			local c_bit = read_bit(c_bit_address, c_bit_index)
			table.insert(binary, c_bit)
			if (i + 1) % 8 == 0 then
				offset = offset - 1
			end
		end
		binary = table.concat(binary)
		for i = 1, 4 do
			local c_hex = string.format("%X", tonumber(string.sub(binary, (i - 1) * 4 + 1, i * 4), 2 ))
			table.insert(hex, c_hex)
		end
		hex = table.concat(hex)
		return hex
	else
		return "0000"
	end
end

function Word16ToHex4(Value)
	if Value < 65536 then
		local binary = DecimalToBinary(Value, 16)
		local hex = {}
		for i = 1, 4 do
			local c_hex = string.format("%X", tonumber(string.sub(binary, (i - 1) * 4 + 1, i * 4), 2 ))
			table.insert(hex, c_hex)
		end
		hex = table.concat(hex)
		return hex
	else
		return "0000"
	end
end

function Byte8ToHex2(Value)
	if Value < 256 then
		local binary = DecimalToBinary(Value, 8)
		local hex = {}
		for i = 1, 2 do
			local c_hex = string.format("%X", tonumber(string.sub(binary, (i - 1) * 4 + 1, i * 4), 2))
			table.insert(hex, c_hex)
		end
		hex = table.concat(hex)
		return hex
	else
		return "00"
	end
end

function BipedStateBoolean(Value, EmptyBit)
	local state = 1 -- Alive/Shields active.
	if EmptyBit == 1 and Value <= 0 then
		state = 0 -- Dead/Shields down.
	end
	return tostring(state)
end

function ReadFloat32ToChar3(Address) -- TESTING: Transforms single-precision float to half-precision, then converts to a decimal number that is translated to base-41 numeral system.
	if Address ~= 0 then
		local binary_sign
		local binary_exponent = {}
		local binary_mantissa = {}
		local binary
		local offset = 3
		for i = 0, 18 do -- Read from memory.
			local c_bit_address = Address + offset
			local c_bit_index = 7 - i + 8 * (3 - offset)
			local c_bit = read_bit(c_bit_address, c_bit_index)
			if i == 0 then
				binary_sign = c_bit
			elseif i > 0 and i < 9 then
				table.insert(binary_exponent, c_bit)
			else
				table.insert(binary_mantissa, c_bit)
			end
			if (i + 1) % 8 == 0 then
				offset = offset - 1
			end
		end
		binary_exponent = tonumber(table.concat(binary_exponent), 2) - 127 + 15 -- 32 bit float to 16 bit.
		if binary_exponent > 31 then
			binary_exponent = 31
		elseif binary_exponent < 0 then
			binary_exponent = 0
		end
		binary_exponent = DecimalToBinary(binary_exponent, 5)
		binary_mantissa = table.concat(binary_mantissa)
		binary = binary_sign..binary_exponent..binary_mantissa
		local quotient = tonumber(binary, 2) -- Convert binary to decimal. REMINDER: This number can't be greater than 65535.
		local cens = 0
		local decs = 0
		local unts = 0
		local base_41 = {}
		while quotient > (1640 + 40) do -- Extract "cens", convert decimal to base 41.
			quotient = quotient - 1681
			cens = cens + 1
		end
		while quotient > (40) do -- Extract "decs"
			quotient = quotient - 41
			decs = decs + 1
		end
		while quotient > (0) do -- Extract "unts"
			quotient = quotient - 1
			unts = unts + 1
		end
		table.insert(base_41, char_table[cens + 1])
		table.insert(base_41, char_table[decs + 1])
		table.insert(base_41, char_table[unts + 1])
		base_41 = table.concat(base_41)
		return base_41
	else
		return "000"
	end
end

function DecimalToBinary(Value, Digits) -- S.L. 5.
	local binary = {}
	local bits = {}
	local quotient = tonumber(Value)
	local modulo
	while quotient > 0 do
		modulo = quotient % 2
		quotient = math.floor(quotient/2)
		table.insert(bits, modulo)
	end
	for i = 1, Digits do
		table.insert(binary, 0)
	end
	for i = 1, #bits do
		local c_bit = bits[#bits - i + 1]
		table.insert(binary, c_bit)
	end
	binary = string.sub(table.concat(binary), -Digits, -1)
	return binary -- String.
end

-- TAG MANIPULATION FUNCTIONS

-- These functions are run only once, every time a new map is loaded. Only fully finished functions are placed inside this section and each one has its own sub-level ID.

function TagManipulationServer(ScenarioPath) -- S.L. 1.
	local scnr_tag_address = lookup_tag("scnr",ScenarioPath)
	local scnr_tag_data = read_dword(scnr_tag_address + 0x14)
	local actors_count = read_dword(scnr_tag_data + 0x420) -- Taken from the "Actor Palette" struct.
	local actors_address = read_dword(scnr_tag_data + 0x420 + 4)
	if actors_count > 0 then
		for i = 0,actors_count - 1 do
			local c_actor_address = actors_address + i * 16
			local c_actor_dpdc_path = read_string(read_dword(c_actor_address + 0x4))
			DeclareBipedType(c_actor_dpdc_path)
		end
	end
	local bipeds_count = read_dword(scnr_tag_data + 0x234) -- Taken from the "Biped Palette" struct.
	local bipeds_address = read_dword(scnr_tag_data + 0x234 + 4)
	if bipeds_count > 0 then
		for i = 0,bipeds_count - 1 do
			local c_biped_address = bipeds_address + i * 48
			local c_biped_dpdc_path = read_string(read_dword(c_biped_address + 0x4))
			local new_biped_type = TryToAddBipedType(c_biped_dpdc_path)
			if new_biped_type == true then -- Weapons used by the bipeds should be tested and added to the weapon tag path tables (if not there yet).
				local tag_address = lookup_tag("bipd", c_biped_dpdc_path)
				local tag_data = read_dword(tag_address + 0x14)
				local biped_weapons_count = read_dword(tag_data + 0x2D8)
				local biped_weapons_address = read_dword(tag_data + 0x2D8 + 4)
				if biped_weapons_count > 0 then
					for i = 0,biped_weapons_count - 1 do
						local c_biped_weapon_address = biped_weapons_address + i * 36
						local c_biped_weapon_path = read_string(read_dword(c_biped_weapon_address + 0x4))
						DeclareWeaponType(c_biped_weapon_path)
					end
				end
			end	
		end
	end
end

function GetScenarioPath()
	local scnr_tag_name_address = read_dword(0x40440028 + 0x10) -- Doesn't work for protected maps.
	local scnr_tag_name = read_string(scnr_tag_name_address)
	return scnr_tag_name
end

function DeclareBipedType(ActorVariantPath) -- S.L. 2: Server version.
	local actv_tag_address = lookup_tag("actv",ActorVariantPath)
	local actv_tag_data = read_dword(actv_tag_address + 0x14)
	local unit_dpdc = read_dword(actv_tag_data + 0x14)
	local unit_dpdc_path = read_string(read_dword(actv_tag_data + 0x14 + 0x4))
	TryToAddBipedType(unit_dpdc_path)
	local actv_actr_dpdc = read_dword(actv_tag_data + 0x04) -- Disable vehicle combat (it is necessary to get AI to sync in vehicles to get rid of this. Coming soon).
	local actv_actr_dpdc_path = read_string(read_dword(actv_tag_data + 0x04 + 0x4))
	local actr_tag_address = lookup_tag("actr",actv_actr_dpdc_path)
	local actr_tag_data = read_dword(actr_tag_address + 0x14)
	local actr_more_flags_bitmask = actr_tag_data + 0x04 -- Location of the bitmask.
	local disallow_vehicle_combat_bit = read_bit(actr_more_flags_bitmask, 3)
	if disallow_vehicle_combat_bit == 0 then
		write_bit(actr_more_flags_bitmask,3,1)
	end
	local actv_weap_dpdc = read_dword(actv_tag_data + 0x64) -- Declare actv's weapon.
	local actv_weap_dpdc_path = read_string(read_dword(actv_tag_data + 0x64 + 0x4))
	DeclareWeaponType(actv_weap_dpdc_path)
	local major_variant_dpdc = read_dword(actv_tag_data + 0x24) -- Declare "Major variant" of this actv.
	local major_variant_dpdc_path = read_string(read_dword(actv_tag_data + 0x24 + 0x4))
	if major_variant_dpdc_path ~= nil then
		DeclareBipedType(major_variant_dpdc_path)
	end
end

function DeclareWeaponType(WeaponPath) -- S.L. 3 (2 & 3): Server version.
	if WeaponPath ~= nil then -- If this actv or biped has a weapon.
		local new = true
		for i = 1,#weapon_paths do -- To avoid registering the same weapon multiple times.
			if weapon_paths[i] == WeaponPath then
				new = false
			end
		end
		if new == true then
			table.insert(weapon_paths,WeaponPath)
			DebugConsolePrint("Weapon tag registered #"..#weapon_paths..": "..WeaponPath, 1, 0x6)
			local weapon_tag_address = lookup_tag("weap",WeaponPath) -- Sets projectiles not to be client side only (So the AI's are visible too. SERVER ONLY).
			local weapon_tag_data = read_dword(weapon_tag_address + 0x14)
			local triggers_count = read_dword(weapon_tag_data + 0x4FC)
			local triggers_bitmask = read_dword(weapon_tag_data + 0x4FC + 4)
			if triggers_count > 0 then -- If this weapon has no triggers. Extremely rare if not impossible, but just in case.
				for trigger = 0,(triggers_count - 1) do
					local c_trigger_bitmask = triggers_bitmask + trigger * 276
					local projectile_is_client_side_only = read_bit(c_trigger_bitmask + 1, 5)
					if projectile_is_client_side_only == 1 and server_side_projectiles == true then
						write_bit(c_trigger_bitmask + 1, 5, 0) -- "Projectile is client side only" set to false.
					end
				end
			end
		end
	end
end

function TryToAddBipedType(Path) -- Server version.
	local new = true
	for i = 1,#biped_paths do -- To avoid registering the same biped type multiple times.
		if biped_paths[i] == Path then
			new = false
		end
	end
	if new == true then
		table.insert(biped_paths, Path) -- Make new list for this biped type.
		biped_lists[#biped_paths] = {}
		DebugConsolePrint("Biped tag registered #"..#biped_paths..": "..Path, 1, 0x6)
	end
	return new
end