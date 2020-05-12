api_version = "1.10.1.0"


--CONFIG

	--	list of all vehicles is in this table. you can just add more and the script will still work just fine

	GAMESETTINGS = {
		["gametype"] = "gta_halo",
		["mapname"] = "dubai0,8"
	}

	BIPEDS = {
		["cops"] = "halo3\\characters\\spartan\\cqb\\cqb",
		["civilians"] = "halo3\\characters\\spartan\\mark v\\mark v",
		["swat"] = "halo3\\characters\\spartan\\odst\\odst"
	}

	WEAPONS = {
		["l85a1"] = "weapons\\l85\\l85a1",
		["remington"] = "weapons\\remington 870\\remington 870",
		["m24"] = "weapons\\m24\\m24",
		["dragunov"] = "weapons\\dragunov\\dragunov_svd",
		["rpg"] = "weapons\\rpg\\rocket_propelled_grenade",
		["m249"] = "weapons\\m249\\m249_saw",
		["vulcan"] = "weapons\\m134-minigun\\m134_minigun",
		["pistol"] = "weapons\\92fs\\92fs_pistol",
		["spistol"] = "weapons\\92fs\\92fs_silenced_pistol",
		["m16"] = "weapons\\m16 m203\\m16_m203",
		["jackhammer"] = "weapons\\pancor jackhammer\\pancor_jackhammer",
		["famas"] = "weapons\\famas\\famas",
		["m4"] = "weapons\\m4\\m4"
	}

	WEAPONPRICES = {
		["l85a1"] = 1000,
		["remington"] = 2500,
		["m24"] = 5000,
		["dragunov"] = 7500, 
		["rpg"] = 10000,
		["m249"] = 25000,
		["vulcan"] = 50000,
		["pistol"] = 200,
		["spistol"] = 500,
		["m16"] = 3500,
		["jackhammer"] = 100000,
		["famas"] = 2500,
		["m4"] = 1000

	}

	COPCARS = {
		["tank"] = "tank",
		["phog"] = "phog",
		["pferrari"] = "pferrari"
	}

	VEHICLES = {
		["911"] = "twisted_metal\\vehicles\\_ff\\porsche",
		["aventador"] = "twisted_metal\\vehicles\\_ff\\aventador",
		["ccx"]  = "twisted_metal\\vehicles\\_ff\\ccx",
		["charger"] = "twisted_metal\\vehicles\\_ff\\charger",
		["murcielago"] = "twisted_metal\\vehicles\\_ff\\lp640",
		["reventon"] = "twisted_metal\\vehicles\\_ff\\reventon",
		["rx7"] = "twisted_metal\\vehicles\\_ff\\rx",
		["veyron"] = "twisted_metal\\vehicles\\_ff\\veyron",
		["zonda"] = "twisted_metal\\vehicles\\zonda\\zonda",
		["gtr"] = "twisted_metal\\vehicles\\gtr\\gtr",
		["countach"] = "twisted_metal\\vehicles\\_v2\\crimsonfury\\crimsonfury",
		["towtruck"] = "twisted_metal\\vehicles\\_v2\\junkyarddog\\junkyarddog",
		["compact"] = "twisted_metal\\vehicles\\_v2\\crazy8\\crazy8",
		["warthog"] = "levels\\test\\racetrack\\custom_hogs\\mp_warthog_green",
		["bfinjection"] = "vehicles\\bfinjection\\bfinjection",
		["cleaver"] = "vehicles\\cleaver\\cleaver",
		["clover"] = "vehicles\\clover\\clover",
		["glendale"] = "vehicles\\glendale\\glendale",
		["sabre"] = "vehicles\\sabre\\sabre",
		["tornado"] = "vehicles\\tornado\\tornado",
		["virgo"] = "vehicles\\virgo\\virgo",
		["tank"] = "vehicles\\scorpion\\scorpion_mp",
		["phog"] = "vehicles\\warthog\\variants\\police\\police_warthog",
		["pferrari"] = "twisted_metal\\vehicles\\police_ferrari\\police_ferrari"
	}

	VEHICLEPRICES = { --prices are defined by taking the counterpart MSRP's of the vehicles, and dividing it by two.
		["911"] = 45550,
		["aventador"] = 199750,
		["ccx"] = 347500,
		["charger"] = 100000, --does not use price scale
		["murcielago"] = 177000,
		["reventon"] = 700000,
		["rx7"] = 950000, --does not use price scale
		["veyron"] = 750000,
		["zonda"] = 725000,
		["gtr"] = 75000, --does not use price scale
		["countach"] = 1500000,
		["towtruck"] = 1250000,
		["compact"] = 1000000,
		["bfinjection"] = 40000,
		["cleaver"] = 100000,
		["clover"] = 30000,
		["glendale"] = 7000,
		["sabre"] = 45000,
		["tornado"] = 25000,
		["virgo"] = 10000
}
--CREDIT: 002 and Altis for switching bipeds
BIPED_IDS = {}
CHOSEN_BIPEDS = {}
DEFAULT_BIPED = nil

--END OF CONFIG

--Startup stuff

function OnScriptLoad()
	register_callback(cb['EVENT_COMMAND'],"OnCommand")
	register_callback(cb['EVENT_VEHICLE_ENTER'], "OnVehicleEnter")
	register_callback(cb['EVENT_VEHICLE_EXIT'], "OnVehicleExit")
	register_callback(cb['EVENT_LEAVE'], "OnPlayerLeave")
	register_callback(cb['EVENT_JOIN'], "OnPlayerJoin")
	register_callback(cb['EVENT_GAME_START'], "OnGameStart")
	register_callback(cb['EVENT_GAME_END'], "OnGameEnd")
	register_callback(cb['EVENT_DIE'], "OnPlayerDie")
	register_callback(cb['EVENT_AREA_ENTER'], "OnAreaEnter")
	register_callback(cb['EVENT_AREA_EXIT'], "OnAreaExit")
	register_callback(cb['EVENT_KILL'], "OnKill")
	register_callback(cb['EVENT_SUICIDE'], "OnSuicide")
	register_callback(cb['EVENT_TICK'], "OnTick")
	register_callback(cb['EVENT_OBJECT_SPAWN'],"OnObjectSpawn")
	--initalizePocket()
	serverIsDesynced = false
	gameStartSequence()
end



--tables

ActivePlayers = {} --All players that are active in the server

RegisteredPlayers = {} --Information of all players registered in the server(s)

PlayerSpawnedVehicles = {} --List of players that have spawned a personal vehicle. Prevents duplicate spawning.

PlayerIsInAVehicle = {} --List of players that are in a vehicle. Prevents players from deleting themselves.

ActivePlayersOwnedCars = {} --List of the cars that active players own.

RegisteredPlayersOwnedCars = {} --List of the cars that all registered players own

PlayerAreas = {} --List of all of the player's that are in key areas (stores, etc.)

timeToReward = 30 * 60 * 30

waitingToReward = 0

serverIsDesynced = false

needToResetGame = false
--end of tables

--Startup stuff

function OnScriptUnload()
	writeToPlayersFile()
	ActivePlayers = {}
	BIPED_IDS = {}
	CHOSEN_BIPEDS = {}
	DEFAULT_BIPED = nil
	RegisteredPlayers = {}
	PlayerSpawnedVehicles = {}
	PlayerIsInAVehicle = {}
	ActivePlayersOwnedCars = {}
	RegisteredPlayersOwnedCars = {}
	PlayerAreas = {}
	waitingToReward = 0
end

--CLASS DEFINITIONS

Pocket = {name = "", hash = "", cash = 0, bank = 0, apartment = 0, copStatus = 0, wantedLevel = 0}

function initalizePocket()
	local Pocket = {name = "", hash = "", cash = 0, bank = 0, apartment = 0, copStatus = 0, wantedLevel = 0}
	return Pocket
end


function Pocket:setName(strname)
	self.name = strname
end

function Pocket.getName(self)
	return self.name
end

function Pocket.setHash(self, strhash)
	self.hash = strhash
end

function Pocket.getHash(self)
	return self.hash
end

function Pocket.getApartment(self)
	return self.apartment
end

function Pocket.setCash(self, bucks)
	self.cash = bucks
end

function Pocket.setBank(self, bucks)
	self.bank = bucks
end

function Pocket.setApartment(self, apartmentStatus)
	self.apartment = apartmentStatus
end

function Pocket.payCash(self, bucks)
    self.cash = self.cash + bucks
end

function Pocket.getCash(self)
    return self.cash
end

function Pocket.deductCash(self, bucks)
	local tempBalance = self.cash - bucks
	if tempBalance < 0 then
		self.cash = 0
	else
		self.cash = self.cash - bucks
	end
end

function Pocket.payBank(self, bucks)
    self.bank = self.bank + bucks;
end

function Pocket.getBank(self)
    return self.bank
end

function Pocket.deductBank(self, bucks)
	local tempBalance = self.bank - bucks
	if tempBalance < 0 then
		self.bank = 0
	else
		self.bank = self.bank - bucks
	end
end

function Pocket.setCopStatus(self, statusNumber)
	statusNumber = tonumber(statusNumber)
	if statusNumber > -1 and statusNumber < 4 then
		self.copStatus = statusNumber
	else
		self.copStatus = 0
	end
end

function Pocket.getCopStatus(self)
	return self.copStatus
end

function Pocket.setWantedLevel(self, WantedLevel)
	self.wantedLevel = WantedLevel
end

function Pocket.getWantedLevel(self)
	return self.wantedLevel
end

function Pocket:new(o)
	o = o or {} --if o is not specified, it will make the object a table, therefore not able to access Pocket's functions.
	setmetatable(o,self)
	self.__index = self
	return o
end

--END CLASS DEFINITIONS

--INITALIZATION


-- ENDINITALIZATION

--UTILITY FUNCTIONS
--CREDIT: 002 - Biped Switch
function FindBipedTag(TagName)
    local tag_array = read_dword(0x40440000)
    for i=0,read_word(0x4044000C)-1 do
        local tag = tag_array + i * 0x20
        if(read_dword(tag) == 1651077220 and read_string(read_dword(tag + 0x10)) == TagName) then
            return read_dword(tag + 0xC)
        end
    end
end

function desync()
	for i=1, 16 do
		if player_present(i) and ActivePlayers[i] == nil then --if the player is active, but their table is nil
			print("desynced")
			serverIsDesynced = true --then the server is desynced
			return true
		else
			return false
		end
	end
end

function resetMap()
	execute_command("sv_map_next")
	execute_command("sv_map "..GAMESETTINGS["mapname"].." "..GAMESETTINGS["gametype"])
end

--CREDIT: Originally by Nickster, changed to suggested implementation by Michelle. 
function getDistance(index1, index2)
	p1x, p1y, p1z = read_vector3d(get_dynamic_player(index1)+0x5C)
	p2x, p2y, p2z = read_vector3d(get_dynamic_player(index2)+0x5C)
	
	return math.sqrt( (p2x-p1x)^2 + (p2y-p1y)^2 + (p2z-p1z)^2 )
end


function playerIsInArea(PlayerIndex, boolLocation )
	local locName = {}
	local playerLocation = PlayerAreas[PlayerIndex]
	for w in playerLocation:gmatch("%a+") do locName[#locName+1] = w end --should take out _<number> in the area
		if locName[1] == boolLocation then
			return true
		else
			return false
		end
end

function ownsThisCar(PlayerIndex, vehicleName) --utility function that checks if a player owns the specified car
	local checkTable = ActivePlayersOwnedCars[PlayerIndex]
	if checkTable[vehicleName] ~= nil then --if the table is nil, the player does not own the car
		rprint(PlayerIndex, "Do you own "..vehicleName.."?")
		return true
	else
		return false
	end
end
--CREDIT: altis - made this for me for twisted metal mod
function vehicleSpawn(PlayerIndex, name, vehicleClass) --utility function for Spawn, particularly for vehicles.
	--say(PlayerIndex, "Getcha ass together boy!")
	PlayerIndex = tonumber(PlayerIndex)
	if player_present(PlayerIndex) then
			execute_command("m "..PlayerIndex.." 0 0 0.4")
			execute_command("spawn vehi "..VEHICLES[name].." "..PlayerIndex)
			execute_command("venter "..PlayerIndex)
	end
end

function Spawn(PlayerIndex, commandargs) --utility function for DriveCommand
	for name, tag in pairs(VEHICLES) do
		if commandargs[1] == name then
			say(PlayerIndex, "Summoning " .. name )
			vehicleSpawn(PlayerIndex, name, commandParameter)
			PlayerSpawnedVehicles[PlayerIndex] = 1
		end
	end
end

function ShowIDFunction(PlayerIndex)
	for i=1, 16 do
		if ActivePlayers[PlayerIndex] ~= nil and ActivePlayers[i] ~= nil then
			if getDistance(PlayerIndex, i) < 2 then
				if ActivePlayers[i].getCopStatus(ActivePlayers[i]) > 0 then
					rprint(PlayerIndex, "You have successfully shown your ID")
					say(i, "Seeing Player ID:      ".."Name: "..get_var(PlayerIndex, "$name").."      PlayerIndex: "..PlayerIndex)
				end
			end
		end
	end
end

function AlertServer(PlayerIndex, message)
	if PlayerIndex ~= nil then
		say(PlayerIndex, message)
	else
		say_all(message)
	end
end

function copCommands(PlayerIndex, commandargs)
	if commandargs[1] == "setwantedlevel" then
		table.remove(commandargs,1)
		WantedPlayer = tonumber(commandargs[1])
		if WantedPlayer ~= nil then
			table.remove(commandargs,1)
			local tempWantedLevel = tonumber(commandargs[1])
			if tempWantedLevel ~= nil then
				ActivePlayers[WantedPlayer].setWantedLevel(ActivePlayers[WantedPlayer], tempWantedLevel)
				if tempWantedLevel > 0 then
					AlertServer(nil, "A wanted level was issued by the police! Be on the lookout for someone suspicious!")
					AlertServer(WantedPlayer, "You now have a wanted level of "..tempWantedLevel)
				else
					AlertServer(nil, "A wanted level has been removed. It is now a little safer...")
					AlertServer(WantedPlayer, "Your wanted level has been removed.")
				end
			else
				rprint(PlayerIndex, "Invalid wanted level was specified!")
			end
		else
			rprint(PlayerIndex, "Invalid player was specified!")
		end
	elseif commandargs[1] == "detain" then
		table.remove(commandargs,1)
		local PlayerToDetain = tonumber(commandargs[1])
		if PlayerToDetain ~= nil then
			distance = getDistance(PlayerIndex, PlayerToDetain)
				if distance < 1 then
					execute_command("s "..PlayerToDetain.." 0")
					AlertServer(PlayerToDetain, "You have been detained!")
				else
					rprint(PlayerIndex, "You are too far away to do that!")
				end
		else
			rprint(PlayerIndex, "Invalid player specified!")
		end
	elseif commandargs[1] == "undetain" then
		table.remove(commandargs,1)
		PlayerToUndetain = tonumber(commandargs[1])
		execute_command("s "..PlayerToUndetain.." 1")
		AlertServer(PlayerToDetain, "You have been undetained!")
	elseif commandargs[1] == "confiscate" then
		table.remove(commandargs,1)
		local PlayerToConfiscate = tonumber(commandargs[1])
		if getDistance(PlayerIndex, PlayerToConfiscate) < 1 then
			execute_command("wdel "..PlayerToConfiscate.." 5")
		else
			rprint(PlayerIndex, "The player is too far away for you to do that!")
		end
	elseif commandargs[1] == "fine" then
		table.remove(commandargs,1)
		local PlayerToFine = commandargs[1]
		if PlayerToFine ~= nil then
			PlayerToFine = tonumber(PlayerToFine)
			table.remove(commandargs,1)
			local amountToFine = commandargs[1]
			if amountToFine ~= nil then
				amountToFine = tonumber(amountToFine)
				local bankBalance = tonumber(ActivePlayers[PlayerToFine].getBank(ActivePlayers[PlayerToFine]))
				if bankBalance ~= nil then
					if amountToFine < bankBalance then --if the player has enough money in their bank
						ActivePlayers[PlayerToFine].deductBank(ActivePlayers[PlayerToFine], amountToFine) --then take the fine out of their bank
					else --otherwise, take it out of their bank and cash
						local cashDifference = amountToFine - bankBalance
						ActivePlayers[PlayerToFine].deductBank(ActivePlayers[PlayerToFine], amountToFine)
						ActivePlayers[PlayerToFine].deductCash(ActivePlayers[PlayerToFine], cashDifference)
					end
				else
					rprint(PlayerIndex, "Invalid fine amount specified!")
				end
			else
				rprint(PlayerIndex, "Invalid fine amount specified")
			end
		else
			rprint(PlayerIndex, "Invalid player index specified!")
		end
	elseif commandargs[1] == "enterhq" then
		if playerIsInArea(PlayerIndex, "hqenter") then
			execute_command("t "..PlayerIndex.." hqentrance")
		else
			rprint(PlayerIndex, "You must be at HQ entrance to enter HQ!")
		end
	elseif commandargs[1] == "enterhqmagically" then
		execute_command("t "..PlayerIndex.." hqentrance")
	elseif commandargs[1] == "exithq" then
		execute_command("t "..PlayerIndex.." hqexit")
	else
		rprint(PlayerIndex, "Invalid cop command was issued!")
	end
end

function payAPlayer(PlayerIndex, amount)
	ActivePlayers[PlayerIndex].payBank(ActivePlayers[PlayerIndex], amount)
end

function buyGun(PlayerIndex, gunToBuy)
	if playerIsInArea(PlayerIndex, "gunstore") then
		if gunToBuy ~= nil then
			if WEAPONS[gunToBuy] ~= nil then
				if WEAPONPRICES[gunToBuy] <= tonumber(ActivePlayers[PlayerIndex].getCash(ActivePlayers[PlayerIndex])) then
					ActivePlayers[PlayerIndex].deductCash(ActivePlayers[PlayerIndex], WEAPONPRICES[gunToBuy])
					gunToGive = spawn_object("weapon", WEAPONS[gunToBuy])
					assign_weapon(gunToGive, PlayerIndex)
					rprint(PlayerIndex, "Purchase of "..gunToBuy.." was successful.")
				else
					rprint(PlayerIndex, "You do not have enough CASH to buy this gun!")
				end
			else
				rprint(PlayerIndex, "An invalid gun was specified!")
			end
		else
			rprint(PlayerIndex, "In order to buy something, you need to specify what you want to buy!")
		end
	else
		rprint(PlayerIndex, "You need to be at a gunstore in order to buy weapons")
	end
end

function buyVehicle(PlayerIndex, vehicleToBuy)
	if playerIsInArea(PlayerIndex, "dealership") then
		if vehicleToBuy ~= nil then --if the vehicle was correctly specified
			if VEHICLES[vehicleToBuy] ~= nil then --and it exists
				if VEHICLEPRICES[vehicleToBuy] <= tonumber(ActivePlayers[PlayerIndex].getCash(ActivePlayers[PlayerIndex])) then --and the player has enough money
					--then they can buy it
					local updatedVehicles = {}
					updatedVehicles = ActivePlayersOwnedCars[PlayerIndex]
					updatedVehicles[vehicleToBuy] = vehicleToBuy
					ActivePlayersOwnedCars[PlayerIndex] = updatedVehicles
					ActivePlayers[PlayerIndex].deductCash(ActivePlayers[PlayerIndex], VEHICLEPRICES[vehicleToBuy])
					rprint(PlayerIndex, "Purchase of "..vehicleToBuy.." was successful.")
				else
					rprint(PlayerIndex, "You do not have enough CASH to buy this vehicle!")
				end
			else
				rprint(PlayerIndex, "An invalid vehicle name was specified!")
			end
		else
			rprint(PlayerIndex, "In order to buy something, you need to specify what you want to buy!")
		end
	else
		rprint(PlayerIndex, "You need to be at a dealership to buy a vehicle!")
	end
end

function NewDriveCommand(PlayerIndex, vehicleToDrive, override)
	if PlayerSpawnedVehicles[PlayerIndex] ~= 1 then --if the player does not have a spawned vehicle
		if playerIsInArea(PlayerIndex, "garage") then --and they are at a valid garage
			if override ~= 0 then
				Spawn(PlayerIndex, commandargs)
			elseif ownsThisCar(PlayerIndex, vehicleToDrive) == true then --and they own the car they want to spawn
				Spawn(PlayerIndex, commandargs) --spawn it
			else --otherwise, let them know that they don't own it.
				rprint(PlayerIndex, "You do not own this vehicle.")
			end
		else --otherwise, let them know that they are not at a valid garage
			rprint(PlayerIndex, "You need to be at a valid garage location!")
		end
	else
		rprint(PlayerIndex, "You already have a summoned vehicle!")
	end
end

function DriveCommand(PlayerIndex, vehicleToDrive) --Summons a specified vehicle for the player that requests it.
	local copOverride = ActivePlayers[PlayerIndex].getCopStatus(ActivePlayers[PlayerIndex])
	copOverride = tonumber(copOverride)
	if copOverride > 0 then
		NewDriveCommand(PlayerIndex, vehicleToDrive, 1)
	else
		NewDriveCommand(PlayerIndex, vehicleToDrive, 0)
	end
end

function setColor(PlayerIndex)
	local copLevel = ActivePlayers[PlayerIndex].getCopStatus(ActivePlayers[PlayerIndex])
	if copLevel > 0 then
		rprint(PlayerIndex, "You will now play as COPS")
		--CHOSEN_BIPEDS[get_var(PlayerIndex, "$hash")] = "swat"
		execute_command("color "..PlayerIndex.." 1")
	else
		rprint(PlayerIndex, "You will now play as CIVILIANS")
		--CHOSEN_BIPEDS[get_var(PlayerIndex, "$hash")] = "civilians"
		execute_command("color "..PlayerIndex.." 0")
	end
end

function ParkCommand(PlayerIndex) --Parks a player's vehicle. Will be modified in the future to ONLY park within certain areas.
	if PlayerIsInAVehicle[PlayerIndex] == 0 then --if the player not in a vehicle
		if playerIsInArea(PlayerIndex, "garage") then --and the player is at a garage
			execute_command("vdel " .. PlayerIndex) --then park their vehicle
			PlayerSpawnedVehicles[PlayerIndex] = 0
		else
			rprint(PlayerIndex, "You need to be at a garage in order to park your car!")
		end
	else --otherwise, let them know that they need to exit the vehicle to park it.
		rprint(PlayerIndex, "You need to exit the vehicle first!")
	end
end

function writeToRegisteredPlayers(PlayerIndex) -- ActivePlayers -> RegisteredPlayers
	local index = get_var(PlayerIndex, "$hash")
	RegisteredPlayers[index] = ActivePlayers[PlayerIndex]
	RegisteredPlayersOwnedCars[index] = ActivePlayersOwnedCars[PlayerIndex]
end

function writeToPlayersFile() --RegisteredPlayers -> players.txt
	if serverIsDesynced == false then
		print("Writing to file.......")
		for i=1, 16 do
			if player_present(i) == true then
				if ActivePlayers[i] ~= nil then
					print("A player was added!")
					writeToRegisteredPlayers(i) -- Writes ActivePlayers -> RegisteredPlayers before writing to players.txt
				else
					print("ERROR: A PLAYER IS PRESENT, BUT THEIR ACTIVE TABLE IS NIL")
				end
			end
		end
		file = io.open("players.txt", "w")
		for name, playerPockets in pairs(RegisteredPlayers) do
			--print("Am I even being called?")
			local dataToWrite = RegisteredPlayers[name]
			if dataToWrite ~= nil then
				--print("writing name...")
				file:write(dataToWrite.getName(dataToWrite))
				file:write("\n")
				--print("writing hash...")
				file:write(dataToWrite.getHash(dataToWrite))
				file:write("\n")
				--print("writing cash...")
				file:write(dataToWrite.getCash(dataToWrite))
				file:write("\n")
				--print("writing bank...")
				file:write(dataToWrite.getBank(dataToWrite))
				file:write("\n")
				--print("writing apartment...")
				file:write(dataToWrite.getApartment(dataToWrite))
				file:write("\n")
				file:write(dataToWrite.getCopStatus(dataToWrite))
				file:write("\n")
				--print("writing wanted level...")
				file:write(dataToWrite.getWantedLevel(dataToWrite))
				file:write("\n")
				--print("writing vehicles...")
				local vehicleTable = RegisteredPlayersOwnedCars[dataToWrite.getHash(dataToWrite)]
				for vehicleName, veh in pairs(vehicleTable) do
				print("in vehicle loop...")
					file:write(vehicleName)
					file:write("\n")
				end
		    	file:write("@EOV")
				file:write("\n")
			else
				print("Something was nil!")
			end
		end
		print("Writing EOF")
		file:write("@EOF")
		file:write("\n")
		print("Done!")
		file:close()
	else
		print("NOT WRITING WHEN THE SERVER IS DESYNCED.")
	end
end

function gameStartSequence() --players.txt -> RegisteredPlayers
	print("\n\n******Loading players.txt...")
	for i=0, 15 do
		PlayerAreas[i] = ""
	end
	inputFile = io.open("players.txt", "r")
	if inputFile == nil then
		print("players.txt does not exist... so let's create it.")
		file = io.open("players.txt", "w")
		file:close()
		inputFile = io.open("players.txt", "r")
	else
		needToRead = true
		while needToRead do
			print("Reading file...")
			local tempPocket = Pocket.new(Pocket)
			local vehicleTable = {}
			--print("test(1)")
			startRead = inputFile:read("*l")
			if startRead ~= "@EOF" and startRead ~= nil then
				tempPocket:setName(startRead)
				tempPocket.setHash(tempPocket, inputFile:read("*l"))
				tempPocket.setCash(tempPocket, inputFile:read("*l"))
				tempPocket.setBank(tempPocket, inputFile:read("*l"))
				tempPocket.setApartment(tempPocket, inputFile:read("*l"))
				tempPocket.setCopStatus(tempPocket, inputFile:read("*l"))
				tempPocket.setWantedLevel(tempPocket, inputFile:read("*l"))
				local readVehicles = true
				while readVehicles do
					--print("test(2)")
					aVehicle = inputFile:read("*l")
					if aVehicle ~= "@EOV" then
						print(aVehicle)
						vehicleTable[aVehicle] = aVehicle
						print(vehicleTable[aVehicle])
					else
						readVehicles = false
					end
				end
			RegisteredPlayers[tempPocket.getHash(tempPocket)] = tempPocket
			RegisteredPlayersOwnedCars[tempPocket.getHash(tempPocket)] = vehicleTable
			elseif startRead == nil then
				needToRead = false
				print("players.txt is empty.")
			else
				needToRead = false
			end
		end
		inputFile:close()
	end
	print("...players.txt loaded!******\n\n")
end

function joiningSequence(PlayerIndex) --RegisteredPlayers -> ActivePlayers
	local playerHash = get_var(PlayerIndex, "$hash")
	rprint(PlayerIndex, playerHash)
	local playerName = get_var(PlayerIndex, "$name")
	rprint(PlayerIndex, playerName)
	local joiningPlayerPockets = RegisteredPlayers[playerHash] --Grab the joining player's information from the RegisteredPlayers table.
	if joiningPlayerPockets ~= nil then --if this information is valid, they are registered.
		if playerHash == joiningPlayerPockets.getHash(joiningPlayerPockets) then
			say(PlayerIndex, "Welcome back "..playerName.."!")
			ActivePlayers[PlayerIndex] = RegisteredPlayers[playerHash]
			ActivePlayersOwnedCars[PlayerIndex] = RegisteredPlayersOwnedCars[playerHash]
			local copLevel = ActivePlayers[PlayerIndex].getCopStatus(ActivePlayers[PlayerIndex])
			if copLevel == 3 then
				say_all("WATCH OUT BOYS AND GIRLS! The sheriff is in town!")
			end
			setColor(PlayerIndex)
		end
	else --if the information is not valid, they are not registered. So register them here.
		say(PlayerIndex, "Welcome to GTA Halo, "..playerName.."!")
		local newPlayerInitalization = Pocket.new(Pocket)
		if newPlayerInitalization ~= nil then
			newPlayerInitalization.setName(newPlayerInitalization, playerName)
			newPlayerInitalization.setHash(newPlayerInitalization, playerHash)
			newPlayerInitalization.setCash(newPlayerInitalization, 5000)
			newPlayerInitalization.setBank(newPlayerInitalization, 0)
			newPlayerInitalization.setApartment(newPlayerInitalization, 0)
			newPlayerInitalization.setCopStatus(newPlayerInitalization, 0)
			newPlayerInitalization.setWantedLevel(newPlayerInitalization, 0)
			local startingCar = {}
			startingCar["warthog"] = "warthog"
			ActivePlayers[PlayerIndex] = newPlayerInitalization
			ActivePlayersOwnedCars[PlayerIndex] = startingCar
		else
			rprint("Pocket.new{} is making things nil.")
		end
	end
end

--END UTILITY FUNCTIONS

--CALLBACKS

function OnCommand(PlayerIndex,Command,Environment,Password)
	if serverIsDesynced == false then
		if player_present(PlayerIndex) then
			Command = string.lower(Command)
			adminLevel = get_var(PlayerIndex, "$lvl") -- Gets player admin level
			adminLevel = tonumber(adminLevel)
			--rprint(PlayerIndex, "You are admin level "..adminLevel)
			commandargs = {}
			for w in Command:gmatch("%w+") do commandargs[#commandargs+1] = w end -- parses the string for spaces, and separates each word of the command into their own elements in the queue.  
			if commandargs[1] == "drive" then --/drive <car> -> summons the specified car if the player owns it.
					table.remove(commandargs, 1) --pop the first element off the command queue.
					local tryingToDriveACopCar = false
					for name, tag in pairs(COPCARS) do
						if name == commandargs[1] then
							tryingToDriveACopCar = true
						end
					end
					if tryingToDriveACopCar then
						local copLevel = ActivePlayers[PlayerIndex].getCopStatus(ActivePlayers[PlayerIndex])
						if copLevel > 0 then
							DriveCommand(PlayerIndex, commandargs[1])
						else
							rprint(PlayerIndex, "You cannot drive this vehicle as a civilian!")
						end
					else
						DriveCommand(PlayerIndex, commandargs[1])
					end
					return false
			elseif commandargs[1] == "park" then --/park -> despawns the specified car if the player owns it
					ParkCommand(PlayerIndex)
					return false
			elseif commandargs[1] == "balance" then --/checkstatus -> debug function
					local aTable = ActivePlayers[PlayerIndex]
					rprint(PlayerIndex, "CASH: "..aTable.getCash(aTable))
					rprint(PlayerIndex, "BANK: "..aTable.getBank(aTable))
					return false
			elseif commandargs[1] == "pay" then --/pay <playerindex> <amount> -> pays player a certain amount of money
					if adminLevel > 0  then
						table.remove(commandargs,1)
						local playerToPay = tonumber(commandargs[1])
						local amountToPay = tonumber(commandargs[2])
						payAPlayer(playerToPay, amountToPay)
					else
						rprint(PlayerIndex, "You do not have sufficent admin privileges to execute this command.")
					end
					return false
			elseif commandargs[1] == "write" then --/write -> debug function. Writes RegisteredPlayers -> players.txt
					if adminLevel == 4 then
						writeToPlayersFile()
					else
						rprint(PlayerIndex, "You do not have admin privileges")
					end
					return false
			elseif commandargs[1] == "buy" then --/buy <objectToBuy> <objectName> -> allows a player to buy something.
					table.remove(commandargs, 1)
					if commandargs[1] ~= nil then
						if commandargs[1] == "car" then
							table.remove(commandargs,1)
							buyVehicle(PlayerIndex, commandargs[1])
						elseif commandargs[1] == "gun" then
							table.remove(commandargs,1)
							buyGun(PlayerIndex, commandargs[1])
						elseif commandargs[1] == "ammo" then

						else
							rprint(PlayerIndex, "You need to specify the object you want to buy! (car/weapon)")
						end
					else
						rprint(PlayerIndex, "buy requires 2 arguments, the object you want to buy, and the name of the object!")
					end
					return false
			elseif commandargs[1] == "withdraw" then --/buy <amount> -> transfers bucks from bank -> cash
					table.remove(commandargs,1)
					if commandargs[1] ~= nil then
						if playerIsInArea(PlayerIndex, "atm") then
							local amountToWithdraw = tonumber(commandargs[1])
							if amountToWithdraw <= tonumber(ActivePlayers[PlayerIndex].getBank(ActivePlayers[PlayerIndex])) then --if they have enough to withdraw
								ActivePlayers[PlayerIndex].deductBank(ActivePlayers[PlayerIndex], amountToWithdraw)
								ActivePlayers[PlayerIndex].payCash(ActivePlayers[PlayerIndex], amountToWithdraw)
								rprint(PlayerIndex, "Withdraw of "..amountToWithdraw.." was successful.")
							else
								rprint(PlayerIndex, "You do not have enough to withdraw!")
							end
						else
							rprint(PlayerIndex, "You are not at an ATM!")
						end
					else
						rprint(PlayerIndex, "You have not specified an amount to withdraw!")
					end

					return false
			elseif commandargs[1] == "deposit" then --/deposit <amount> -> transfers bucks from cash -> bank
					table.remove(commandargs,1)
					if commandargs[1] ~= nil then
						if playerIsInArea(PlayerIndex, "atm")  then
							local amountToDeposit = tonumber(commandargs[1])
							if amountToDeposit <= tonumber(ActivePlayers[PlayerIndex].getCash(ActivePlayers[PlayerIndex])) then --if they have enough to withdraw
								ActivePlayers[PlayerIndex].deductCash(ActivePlayers[PlayerIndex], amountToDeposit)
								ActivePlayers[PlayerIndex].payBank(ActivePlayers[PlayerIndex], amountToDeposit)
								rprint(PlayerIndex, "Deposit of "..amountToDeposit.." was successful.")
							else
								rprint(PlayerIndex, "You do not have enough to deposit!")
							end
						else
							rprint(PlayerIndex, "You are not at an ATM!")
						end
					else
						rprint(PlayerIndex, "You have not specified an amount to deposit!")
					end
					return false
			elseif commandargs[1] == "seeregtable" then
					for hash, data in pairs(RegisteredPlayers) do
						rprint(PlayerIndex, hash)
						rprint(PlayerIndex, "NAME "..RegisteredPlayers[hash].getName(RegisteredPlayers[hash]))
						rprint(PlayerIndex, "HASH "..RegisteredPlayers[hash].getHash(RegisteredPlayers[hash]))
						rprint(PlayerIndex, "CASH "..RegisteredPlayers[hash].getCash(RegisteredPlayers[hash]))
						rprint(PlayerIndex, "BANK "..RegisteredPlayers[hash].getBank(RegisteredPlayers[hash]))
						rprint(PlayerIndex, "\n")
					end
					return false
			elseif commandargs[1] == "seeactivetable" then
					for index, data in pairs(ActivePlayers) do
						rprint(PlayerIndex, "Showing active table...")
						rprint(PlayerIndex, index)
						rprint(PlayerIndex, "NAME "..ActivePlayers[index].getName(ActivePlayers[index]))
						rprint(PlayerIndex, "HASH "..ActivePlayers[index].getHash(ActivePlayers[index]))
						rprint(PlayerIndex, "CASH "..ActivePlayers[index].getCash(ActivePlayers[index]))
						rprint(PlayerIndex, "BANK "..ActivePlayers[index].getBank(ActivePlayers[index]))
						rprint(PlayerIndex, "\n")
					end
					return false
			elseif commandargs[1] == "cop" then
					local tempCopStatus = ActivePlayers[PlayerIndex].getCopStatus(ActivePlayers[PlayerIndex])
					if tempCopStatus > 0 then
						table.remove(commandargs,1)
						copCommands(PlayerIndex, commandargs)
					else
						rprint(PlayerIndex, "You must be a cop to execute a cop command!")
					end
				return false
			elseif commandargs[1] == "setcopstatus" then
					if adminLevel >= 4 then
						table.remove(commandargs,1)
						local NewCop = tonumber(commandargs[1])
						if NewCop ~= nil then
							table.remove(commandargs,1)
							local NewCopStatus = tonumber(commandargs[1])
							if NewCopStatus ~= nil then
								if NewCopStatus >= 0 and NewCopStatus < 4 then
									ActivePlayers[NewCop].setCopStatus(ActivePlayers[NewCop], NewCopStatus)
									if NewCopStatus > 0 then --if the cop is being fired
										--setcopbiped
										rprint(NewCop, "You will now play as COPS")
										--CHOSEN_BIPEDS[get_var(NewCop, "$hash")] = "swat"
										execute_command("color "..PlayerIndex.." 1")
									else
										rprint(NewCop, "You will now play as CIVILIANS")
										execute_command("color "..PlayerIndex.." 0")
										--CHOSEN_BIPEDS[get_var(NewCop, "$hash")] = "civilians"
										--setcivilianbiped
									end
									execute_command("kill "..NewCop)
								else
									rprint(PlayerIndex, "Invalid cop level. Cop levels are between 0 and 3")
								end
							end
						end
					else
						rprint(PlayerIndex, "You do not have permission to hire cops!")
					end
					return false
			elseif commandargs[1] == "showid" then
					ShowIDFunction(PlayerIndex)
					return false
			elseif commandargs[1] == "drop" then
					drop_weapon(PlayerIndex)
					return false
			elseif commandargs[1] == "errortest" then
					local testErrorMessage = nil
					rprint(PlayerIndex, testErrorMessage)
					return false
			end
		end
	else
		rprint(PlayerIndex, "You cannot issue a command while the server is desynced!")
	end
end 

function OnVehicleEnter(PlayerIndex)
	PlayerIsInAVehicle[PlayerIndex] = 1
end

function OnVehicleExit(PlayerIndex)
	PlayerIsInAVehicle[PlayerIndex] = 0
end

function OnPlayerLeave(PlayerIndex)
	execute_command("vdel " .. PlayerIndex)
	PlayerIsInAVehicle[PlayerIndex] = 0
	PlayerSpawnedVehicles[PlayerIndex] = 0
	writeToRegisteredPlayers(PlayerIndex)
	writeToPlayersFile() --probably needs to be removed in the future.
end

function OnGameStart()
	--gameStartSequence()
	print("Starting game...")
end

function OnPlayerJoin(PlayerIndex)
	joiningSequence(PlayerIndex)
end

function OnGameEnd()
	writeToPlayersFile()
end

function OnPlayerDie(PlayerIndex, message)
	execute_command("vdel " .. PlayerIndex)
	PlayerIsInAVehicle[PlayerIndex] = 0
	PlayerSpawnedVehicles[PlayerIndex] = 0
	setColor(PlayerIndex)
end

function OnAreaEnter(PlayerIndex, areaEntered)
	PlayerAreas[PlayerIndex] = areaEntered
	rprint(PlayerIndex, "You have entered "..areaEntered)
end

function OnAreaExit(PlayerIndex, areaExited)
	PlayerAreas[PlayerIndex] = ""
	rprint(PlayerIndex, "You have exited "..areaExited)
end

function OnKill(PlayerIndex, VictimIndex) --if a player kills someone
	rprint(PlayerIndex, "You earned money!")
	rprint(VictimIndex, "You lost money!")
	VictimIndex = tonumber(VictimIndex)
	local droppedCash = ActivePlayers[VictimIndex].getCash(ActivePlayers[VictimIndex])
	ActivePlayers[PlayerIndex].payCash(ActivePlayers[PlayerIndex], droppedCash)
	ActivePlayers[VictimIndex].setCash(ActivePlayers[VictimIndex], 1000) --and the victim loses their cash
end

function OnSuicide(PlayerIndex)
	ActivePlayers[PlayerIndex].setCash(ActivePlayers[PlayerIndex], 0)
end

function OnTick()
	if desync() == true then
		print("The server has desynced. Resetting the game now.")
		needToResetGame = true
	end
	if waitingToReward > timeToReward then
		AlertServer(nil, "Welfare has been distributed!")
		for i=1, 16 do
			if ActivePlayers[i] ~= nil then
				ActivePlayers[i].payCash(ActivePlayers[i], 2500)
			end
		end
		waitingToReward = 0
	else
		waitingToReward = waitingToReward + 1
	end
	if needToResetGame == true then
		needToResetGame = false
		resetMap()
	end
end

function OnObjectSpawn(PlayerIndex, MapID, ParentID, ObjectID)
    if(player_present(PlayerIndex) == false) then return true end --if player does not exist, do not execute. otherwise, proceed.
    if(DEFAULT_BIPED == nil) then --if the default biped is nil, then read into the globals, and grab it out of the globals.
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
    local hash = get_var(PlayerIndex,"$hash") --retrieves the player indexes CD hash to use it as an index in the CHOSEN_BIPEDS table.
    if(MapID == DEFAULT_BIPED and CHOSEN_BIPEDS[hash]) then --if the Tag ID matches the default biped, and the chosen biped matches the hash.
        for key,value in pairs(BIPEDS) do --(note: key and value represent "i"). Find the biped tag.
            if(BIPED_IDS[key] == nil) then --if it is found, overwrite.
                BIPED_IDS[key] = FindBipedTag(BIPEDS[key])
            end
        end
        return true,BIPED_IDS[CHOSEN_BIPEDS[hash]] --and return it. (in case it is not found, it does not get over-written.)
    end
    return true
end

function OnGameEnd()
writeToPlayersFile()
OnGameEnd = OnScriptUnload
end

function OnError(message)
	say_all("error was called")
	for i=0, 16 do
		if tonumber(get_var(i, "$lvl")) > 1 then -- Gets player admin level
			rprint(i, message)
		end
	end
	file = io.open("errors.txt", "a")
	file:write(message)
	file:write("\n")
	file:close()
end


--NOTES:
		--    rprint(PlayerIndex, #commandargs);
		--    for i=1, #commandargs do
		-- 		local aString = commandargs[i]
		-- 		rprint(PlayerIndex, aString)
		--    end
		--    commandargsTest = commandargs
		--    number = #commandargsTest
		--    rprint(PlayerIndex, "popping elements off the queue")
		--    for i=1, number do
		-- 		rprint(PlayerIndex, #commandargsTest)
		-- 		local aString = commandargsTest[1];
		-- 		table.remove(commandargsTest, 1)
		-- 		rprint(PlayerIndex, aString)	
		--    end