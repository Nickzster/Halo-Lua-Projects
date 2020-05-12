api_version = "1.10.1.0"
--Global Variables File
--Define your variables in here.


--Changeable tables. These may be changed depending on the map being played on. Designed for GTA_Badlands.
carEvent = false
moneyEvent = false
gunEvent = false
freeGun = "remington"
freeCar = "countach"
freeMoney = 10000
MAXBUCKS = 9999999
MAXKARMA = 2.0
maxAmmoPrice = 750
loadoutChangePrice = 500
ClaimedRewards = {}
LOCATIONS = {
    ["dealership_1"] = "the dealership in Camel.",
    ["dealership_2"] = "the anarchist dealership.",
    ["garage_5"] = "the garage in Camel.",
    ["apartments"] = "the apartments in Camel.",
    ["gunstore_3"] = "the downtown ammunation in Camel.",
    ["garage_1"] = "a garage in Cottontail.",
    ["garage_2"] = "a garage in Foxtown.",
    ["garage_3"] = "a garage in Scropion Claw.",
    ["garage_4"] = "a garage in Scropion Tail.",
    ["gunstore_1"] = "an ammunation in Foxtown.",
    ["gunstore_2"] = "an ammunation in Scropion",
    ["recruiter"] = "the recruiter in Camel."
}
PROFESSIONS = {
    ["sheriff"] = 10000,
    ["deputy"] = 7500,
    ["officer"] = 5000,
    ["civilian"] = 1500,
    ["robber"] = 0,
    ["delinquent"] = 0
}
COPPOSITIONS = {
    [0] = "civilian",
    [1] = "officer",
    [2] = "deputy",
    [3] = "sheriff"
}
GAMESETTINGS = {
    ["gametype"] = "gta_halo",
    ["mapname"] = "gta_badlands"
}
BIPEDS = {
    ["cops"] = "halo3\\characters\\spartan\\cqb\\cqb",
    ["civilians"] = "halo3\\characters\\spartan\\mark v\\mark v",
    ["swat"] = "halo3\\characters\\spartan\\odst\\odst"
}
WEAPONS = {
    ["remington"] = "gta_halo\\weapons\\remington 870\\remington870",
    ["m249"] = "gta_halo\\weapons\\m249\\m249saw",
    ["mg36"] = "gta_halo\\weapons\\mg36\\mg36",
    ["benelli"] = "gta_halo\\weapons\\benelli_shotgun\\benelli_shotgun",
    ["g36"] = "gta_halo\\weapons\\cod4\\weapons\\g36\\g36",
    ["m16"] = "gta_halo\\weapons\\cod4\\weapons\\m16\\m16",
    ["mp5sd"] = "gta_halo\\weapons\\cod4\\weapons\\mp5\\mp5sd",
    ["aa12"] = "gta_halo\\weapons\\dsmt\\weapons\\aa12\\aa12",
    ["as50"] = "gta_halo\\weapons\\dsmt\\weapons\\as-50\\as-50",
    ["g17"] = "gta_halo\\weapons\\dsmt\\weapons\\g17\\g17",
    ["kdw"] = "gta_halo\\weapons\\dsmt\\weapons\\kdw\\gta_kdw",
    ["m4"] = "gta_halo\\weapons\\dsmt\\weapons\\m4\\m4",
    ["mp5k"] = "gta_halo\\weapons\\dsmt\\weapons\\mp5k\\mp5k",
    ["revolver"] = "gta_halo\\weapons\\dsmt\\weapons\\mr96\\mr96revolver",
    ["ak47"] = "gta_halo\\deathstar\\ambush\\weapon\\ak47",
    ["sniper"] = "gta_halo\\deathstar\\ambush\\weapon\\sniper",
    ["uzi"] = "gta_halo\\deathstar\\ambush\\weapon\\uzi",
    ["m27"] = "gta_halo\\weapons\\sideffect\\weapons\\m27\\m27",
    ["mrifle"] = "gta_halo\\weapons\\sideffect\\weapons\\marksman_rifle\\marksman_rifle",
    ["shotgun"] = "gta_halo\\weapons\\sideffect\\weapons\\shotgun\\shotgun",
    ["smg"] = "gta_halo\\weapons\\sideffect\\weapons\\smg\\smg",
    ["usp"] = "gta_halo\\weapons\\mw\\weapons\\hk-usp\\mw2-usp",
    ["m4a1"] = "gta_halo\\weapons\\m4a1\\m4a1"
}
WEAPONPRICES = {
    ["remington"] = 800,
    ["m249"] = 5000,
    ["mg36"] = 4000,
    ["benelli"] = 1000,
    ["g36"] = 1400,
    ["m16"] = 1500,
    ["mp5sd"] = 1000,
    ["aa12"] = 2000,
    ["as50"] = 2000,
    ["g17"] = 400,
    ["kdw"] = 600,
    ["m4"] = 1700,
    ["mp5k"] = 900,
    ["revolver"] = 1200,
    ["ak47"] = 1600,
    ["sniper"] = 2500,
    ["uzi"] = 800,
    ["m27"] = 1600,
    ["mrifle"] = 1800,
    ["shotgun"] = 900,
    ["smg"] = 1100,
    ["usp"] = 600,
    ["m4a1"] = 1400
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
    ["countach"] = "altis\\crashday\\judge\\unarmed red judge",
    ["towtruck"] = "twisted_metal\\vehicles\\_v2\\junkyarddog\\junkyarddog",
    ["compact"] = "twisted_metal\\vehicles\\_v2\\crazy8\\crazy8",
    ["cwarthog"] = "vehicles\\yohog\\yohog",
    ["bfinjection"] = "vehicles\\bfinjection\\bfinjection",
    ["cleaver"] = "vehicles\\cleaver\\cleaver",
    ["clover"] = "vehicles\\clover\\clover",
    ["glendale"] = "vehicles\\glendale\\glendale",
    ["sabre"] = "vehicles\\sabre\\sabre",
    ["tornado"] = "vehicles\\tornado\\tornado",
    ["virgo"] = "vehicles\\virgo\\virgo",
    ["challenger"] = "twisted_metal\\vehicles\\challenger\\challenger",
    ["veneno"] = "twisted_metal\\vehicles\\_v3\\veneno_low_poly\\veneno",
    ["vincent"] = "altis\\vehicles\\vincent\\vincent"
     
}
VEHICLEPRICES = { 
    ["veneno"] = 75000,
    ["countach"] = 10000,
    ["challenger"] = 8000,
    ["compact"] = 90000,
    ["charger"] = 7500, --does not use price scale
    ["rx7"] = 62500, --does not use price scale
    ["zonda"] = 17500,
    ["bfinjection"] = 4000,
    ["clover"] = 3000,
    ["glendale"] = 700,
    ["sabre"] = 4500,
    ["tornado"] = 2500,
    ["virgo"] = 1000,
    ["vincent"] = 7500
}
--CREDIT: 002 and Altis for switching bipeds
BIPED_IDS = {}
CHOSEN_BIPEDS = {}
DEFAULT_BIPED = nil

--dynamic tables
ActivePlayers = {} --All players that are active in the server
PlayerSpawnedVehicles = {} --List of players that have spawned a personal vehicle. Prevents duplicate spawning.
PlayerIsInAVehicle = {} --List of players that are in a vehicle. Prevents players from deleting themselves.
ActivePlayersOwnedCars = {} --List of the cars that active players own.
ActivePlayersOwnedWeapons = {} --list of the weapons that active players own
PlayerAreas = {} --List of all of the player's that are in key areas (stores, etc.)
timeToReward = 30 * 60 * 30
waitingToReward = 0
needToResetGame = false
--end of dynamic tables
--end of Startup stuff
--CLASS DEFINITIONS
Inventory = {
	name = "", --string value representing players name
	hash = "", --string value representing players hash
	bucks = 5000, --int value representing players money
	profession = "civilian", --string value representing player's profession
	karma = 1, --int value representing player's karma value
    apartment = 0, --bool value (0 or 1) representing if a player has an apartment
	copPosition = 0, --0 = not a cop, 1 = officer, 2 = deputy, 3 = sheriff
	copAuthority = 0, --bool value (0 or 1) representing if a player has authority or not.
    fugitiveStatus = 0, --bool value (0 or 1) representing if a player is made or not
    loadoutPrimary = "empty", --string value representing primary weapon
    loadoutSecondary = "empty", --string value representing secondary weapon
    jailStatus = 0, --bool value (0 or 1) value representing if a player is in jail or not
}

function AlertServer(PlayerIndex, message)
	if PlayerIndex ~= nil then
		say(PlayerIndex, message)
	else
		say_all(message)
	end
end

function desync()
	for i=1, 16 do
		if player_present(i) then
			if ActivePlayers[i] == nil then --if the player is active, but their table is nil
				return true
			else
				return false
			end
		else
			return false
		end
	end
end

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

--CREDIT: Originally by Nickster, changed to suggested implementation by Michelle. 
function getDistance(index1, index2)
	p1x, p1y, p1z = read_vector3d(get_dynamic_player(index1)+0x5C)
	p2x, p2y, p2z = read_vector3d(get_dynamic_player(index2)+0x5C)
	
	return math.sqrt( (p2x-p1x)^2 + (p2y-p1y)^2 + (p2z-p1z)^2 )
end

function giveGun(weaponName, PlayerIndex)
	local gunToGive = spawn_object("weapon", WEAPONS[weaponName])
	assign_weapon(gunToGive, tonumber(PlayerIndex))
end

Inventory = {
	name = "", --string value representing players name
	hash = "", --string value representing players hash
	bucks = 5000, --int value representing players money
	profession = "civilian", --string value representing player's profession
	karma = 1.0, --int value representing player's karma value
    apartment = 0, --bool value (0 or 1) representing if a player has an apartment
	copPosition = 0, --0 = not a cop, 1 = officer, 2 = deputy, 3 = sheriff
	copAuthority = 0, --bool value (0 or 1) representing if a player has authority or not.
    fugitiveStatus = 0, --bool value (0 or 1) representing if a player is made or not
    loadoutPrimary = "empty", --string value representing primary weapon
    loadoutSecondary = "empty", --string value representing secondary weapon
    jailStatus = 0, --bool value (0 or 1) value representing if a player is in jail or not
}
--Class methods
--name getters + setters
function Inventory:setName(strname)
	self.name = strname
end
function Inventory:getName()
	return self.name
end
--hash getters + setters
function Inventory:setHash(strhash)
	self.hash = strhash
end
function Inventory:getHash()
	return self.hash
end
--bucks setters + getters
function Inventory:setBucks(bucks)
	if tonumber(bucks) > MAXBUCKS then
		self.bucks = MAXBUCKS
	else
		self.bucks = bucks
	end
end
function Inventory:getBucks(bucks)
	return self.bucks
end
function Inventory:payBucks(bucks) --adds ONTO the amount of bucks a player has
	local tempBalance = self.bucks + bucks
	if tempBalance > MAXBUCKS then
		self.bucks = MAXBUCKS
	else
		self.bucks = tempBalance
	end
end
function Inventory:deductBucks(bucks) --deducts cash out of player's inventory. this value cannot dip below 0.
	local tempBalance = self.bucks - bucks
	if tempBalance < 0 then --if the amount of cash deducted would be below zero
		self.bucks = 0 --then set their amount of cash to 0
	else
		self.bucks = self.bucks - bucks --otherwise do the deduction.
	end
end
--profession setters and getters
function Inventory:setProfession(professionToBe) 
    if PROFESSIONS[professionToBe] ~= nil then --if this profession is in the list of professions
		self.profession = professionToBe  --then set it to the player's profession value
		return true
    else
        return false --otherwise return false, and deny the addition of the profession to the player.
    end
end
function Inventory:getProfession()
    return self.profession
end
--karma setters and getters
function Inventory:setKarma(newKarmaValue)
	newKarmaValue = tonumber(newKarmaValue)
	if newKarmaValue > MAXKARMA then
		self.karma = MAXKARMA
	else
		self.karma = newKarmaValue
	end
end
function Inventory:getKarma()
	return self.karma
end
function Inventory:incrementKarma()
	local incrementedKarmaValue = self.karma + 1
	if incrementedKarmaValue > MAXKARMA then
		self.karma = MAXKARMA
	else
		self.karma = incrementedKarmaValue
	end
end
--cop getters and setters
function Inventory:setCopPosition(newCopPositionNumber)
	local newCopPosition = COPPOSITIONS[newCopPositionNumber]
	if newCopPosition ~= nil then
		self.copPosition = newCopPositionNumber
		return true
	else
		self.copPosition = 0
		return false
	end
end
function Inventory:getCopPosition()
	return self.copPosition
end
--authority setters and getters
function Inventory:setCopAuthority(newAuthorityValue)
	self.copAuthority = newAuthorityValue
end
function Inventory:getCopAuthority()
	return self.copAuthority
end
--apartment status getters + setters
function Inventory:setApartment(apartmentStatus)
	self.apartment = apartmentStatus
end
function Inventory:getApartment()
	return self.apartment
end
function Inventory:getCopRank()
	return self.copRank
end
--fugitive status setters + getters
function Inventory:setFugitiveStatus(fugitiveStatusToBe)
    self.fugitiveStatus = fugitiveStatusToBe
end
function Inventory:getFugitiveStatus()
    return self.fugitiveStatus
end
--set loadouts
function Inventory:setLoadoutPrimary(primaryWeapon) 
    self.loadoutPrimary = primaryWeapon
end
function Inventory:setLoadoutSecondary(secondaryWeapon) --used for io
	self.loadoutSecondary = secondaryWeapon
end
function Inventory:setLoadout(primaryWeapon, secondaryWeapon)
	self.loadoutPrimary = primaryWeapon
    self.loadoutSecondary = secondaryWeapon
end
--get loadouts
function Inventory:getPrimaryWeapon()
    return self.loadoutPrimary
end
function Inventory:getSecondaryWeapon()
    return self.loadoutSecondary
end
function Inventory:setJailStatus(jailStatusToBe)
	self.jailStatus = jailStatusToBe
end
function Inventory:getJailStatus()
	return self.jailStatus
end

function Inventory:new(o)
	o = o or {} --if o is not specified, it will make the object a table, therefore not able to access Inventory's functions.
	setmetatable(o,self)
	self.__index = self
	return o
end

------------------------------------------------------------
-- from sam_lie
-- Compatible with Lua 5.0 and 5.1.
-- Disclaimer : use at own risk especially for hedge fund reports :-)
--http://lua-users.org/wiki/FormattingNumbers
---============================================================
-- add comma to separate thousands
-- 
function comma_value(amount)
	local formatted = amount
	while true do  
	  formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
	  if (k==0) then
		break
	  end
	end
	return formatted
end
  -- rounds a number to the nearest decimal places
function round(val, decimal)
	if (decimal) then
	  return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
	else
	  return math.floor(val+0.5)
	end
end
  -- given a numeric value formats output with comma to separate thousands
  -- and rounded to given decimal places
function format_num(amount, decimal, prefix, neg_prefix)
	local str_amount,  formatted, famount, remain
  
	decimal = decimal or 2  -- default 2 decimal places
	neg_prefix = neg_prefix or "-" -- default negative sign
  
	famount = math.abs(round(amount,decimal))
	famount = math.floor(famount)
  
	remain = round(math.abs(amount) - famount, decimal)
  
		  -- comma to separate the thousands
	formatted = comma_value(famount)
  
		  -- attach the decimal portion
	if (decimal > 0) then
	  remain = string.sub(tostring(remain),3)
	  formatted = formatted .. "." .. remain ..
				  string.rep("0", decimal - string.len(remain))
	end
  
		  -- attach prefix string e.g '$' 
	formatted = (prefix or "") .. formatted 
  
		  -- if value is negative then format accordingly
	if (amount<0) then
	  if (neg_prefix=="()") then
		formatted = "("..formatted ..")"
	  else
		formatted = neg_prefix .. formatted 
	  end
	end
  
	return formatted
end
function niceMoneyDisplay(bucksToDisplay)
	bucksToDisplay = tonumber(bucksToDisplay)
	return format_num(bucksToDisplay, 2, "$")
end

function payAPlayer(PlayerIndex, amount)
	ActivePlayers[PlayerIndex].payBucks(ActivePlayers[PlayerIndex], amount)
end

function playerIsInArea(PlayerIndex, boolLocation)
	local locName = {}
	local playerLocation = PlayerAreas[PlayerIndex]
	if playerLocation ~= nil then
		for w in playerLocation:gmatch("%a+") do locName[#locName+1] = w end --should take out _<number> in the area
			if locName[1] == boolLocation then
				return true
			else
				return false
		end
	else
		rprint(PlayerIndex, "You are not in the correct area to be doing that!")
	end
end

function writePlayerData(PlayerIndex) --ActivePlayers -> $hash
	print("\nWriting"..get_var(PlayerIndex, "$name").."'s data to a file.")
	local hashNumber = get_var(PlayerIndex, "$hash")
	local hashFile = "player_data_files/"..hashNumber
	print("\n It is in"..hashFile)
	local file = io.open(hashFile, "w")
	--error("Writing... "..hash)
	--print("writing name...")
	file:write("$PLAYER_NAME")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getName())
	file:write("\n")
	file:write("$PLAYER_HASH")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getHash())
	file:write("\n")
	file:write("$PLAYER_BUCKS")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getBucks())
	file:write("\n")
	file:write("$PLAYER_PROFESSION")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getProfession())
	file:write("\n")
	file:write("$PLAYER_KARMA")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getKarma())
	file:write("\n")
	file:write("$PLAYER_APARTMENTSTATUS")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getApartment())
	file:write("\n")
	file:write("$PLAYER_COPPOSITION")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getCopPosition())
	file:write("\n")
	file:write("$PLAYER_AUTHORITY")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getCopAuthority())
	file:write("\n")
	file:write("$PLAYER_FUGITIVESTATUS")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getFugitiveStatus())
	file:write("\n")
	file:write("$PLAYER_LOADOUTPRIMARY")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getPrimaryWeapon())
	file:write("\n")
	file:write("$PLAYER_LOADOUTSECONDARY")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getSecondaryWeapon())
	file:write("\n")
	file:write("$PLAYER_JAILSTATUS")
	file:write("\n")
	file:write(ActivePlayers[PlayerIndex]:getJailStatus())
	file:write("\n")
	--print("writing vehicles...")
	file:write("@PLAYER_OWNEDVEHICLES")
	file:write("\n")
	local vehicleTable = ActivePlayersOwnedCars[PlayerIndex]
		for vehicleName, veh in pairs(vehicleTable) do
			file:write(vehicleName)
			file:write("\n")
		end
	file:write("@PLAYER_OWNEDVEHICLES")
	file:write("\n")
	file:write("@PLAYER_OWNEDWEAPONS")
	file:write("\n")
	local weaponTable = ActivePlayersOwnedWeapons[PlayerIndex]
		for weaponName, weap in pairs(weaponTable) do
			file:write(weaponName)
			file:write("\n")
		end
	file:write("@PLAYER_OWNEDWEAPONS")
	file:write("\n")
	file:write("$EOF")
	print("Done!")
	file:close()	
end
function getPlayerData(PlayerIndex) --$hash -> ActivePlayers
	local fileHash = get_var(PlayerIndex, "$hash")
	local filename = "player_data_files/"..fileHash
	local inputFile = io.open(filename, "r") 
	local tempInventory = Inventory.new(Inventory)
	local tempVehicleTable = {}
	local tempWeaponTable = {}
	local playerName = get_var(PlayerIndex, "$name")
	if inputFile ~= nil then --if the file exists, then read the data in that way
		say(PlayerIndex, "Welcome BACK, "..playerName.."!")
		local endOfFile = false
		while endOfFile == false do
			local valueToCompare = inputFile:read("*l")
			print("\nChecking "..valueToCompare.." to see if it is valid.")
			if valueToCompare == "$PLAYER_NAME" then
				tempInventory:setName(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_HASH" then
				tempInventory:setHash(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_BUCKS" then
				tempInventory:setBucks(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_PROFESSION" then
				tempInventory:setProfession(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_KARMA" then
				tempInventory:setKarma(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_APARTMENTSTATUS" then
				tempInventory:setApartment(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_COPPOSITION" then
				tempInventory:setCopPosition(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_AUTHORITY" then
				tempInventory:setCopAuthority(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_FUGITIVESTATUS" then 
				tempInventory:setFugitiveStatus(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_LOADOUTPRIMARY" then
				tempInventory:setLoadoutPrimary(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_LOADOUTSECONDARY" then
				tempInventory:setLoadoutSecondary(inputFile:read("*l"))
			elseif valueToCompare == "$PLAYER_JAILSTATUS" then
				tempInventory:setJailStatus(inputFile:read("*l"))
			elseif valueToCompare == "@PLAYER_OWNEDVEHICLES" then
				local readVehicles = true
				while readVehicles do
					local aVehicle = inputFile:read("*l")
					if aVehicle ~= "@PLAYER_OWNEDVEHICLES" then
						print("\n ***player owns a "..aVehicle.."\n")
						tempVehicleTable[aVehicle] = aVehicle
					else
						readVehicles = false
					end
				end
			elseif valueToCompare == "@PLAYER_OWNEDWEAPONS" then
				local readWeapons = true
				while readWeapons do
					local aWeapon = inputFile:read("*l")
					if aWeapon ~= "@PLAYER_OWNEDWEAPONS" then
						print("\n ***player owns a "..aWeapon.."\n")
						tempWeaponTable[aWeapon] = aWeapon
					else
						readWeapons = false
					end
				end
			elseif valueToCompare == "$EOF" then
				print("\nEnd of file reached.")
				endOfFile = true
			else
				print("\nRemoving depricated feature...\n")
			end
		end
		inputFile:close()
	else --otherwise, set default values.
		say(PlayerIndex, "Welcome to GTA Halo, "..playerName.."!")
		tempInventory:setName(playerName)
		tempInventory:setHash(fileHash)
		tempInventory:setBucks(5000)
		tempInventory:setApartment(0)
		tempInventory:setKarma(1)
		tempInventory:setCopPosition("")
		tempInventory:setCopAuthority(0)
		tempInventory:setProfession("civilian")
		tempInventory:setFugitiveStatus(0)
		tempInventory:setLoadout("empty","empty")
		tempInventory:setJailStatus(0)
		tempVehicleTable = {["cwarthog"] = "cwarthog"}
		tempWeaponTable = {["g17"] = "g17"}
	end
	ActivePlayers[PlayerIndex] = tempInventory
	ActivePlayersOwnedCars[PlayerIndex] = tempVehicleTable
	ActivePlayersOwnedWeapons[PlayerIndex] = tempWeaponTable
	if ActivePlayers[PlayerIndex]:getProfession() == "officer" then
		AlertServer(nil, "An officer has just signed in.")
	elseif ActivePlayers[PlayerIndex]:getProfession() == "deputy" then
		AlertServer(nil, "The deputy is in town!")
	elseif ActivePlayers[PlayerIndex]:getProfession() == "sheriff" then
		AlertServer(nil, "Look out boys! The Sheriff's in town.")
	end
end

function setColor(PlayerIndex)
	rprint(PlayerIndex, "SetColor Called (WIP function)")
	-- local copRank = ActivePlayers[PlayerIndex]:getCopRank()
	-- if copRank > 0 then
	-- 	rprint(PlayerIndex, "You will now play as COPS")
	-- 	--CHOSEN_BIPEDS[get_var(PlayerIndex, "$hash")] = "swat"
	-- 	execute_command("color "..PlayerIndex.." 1")
	-- else
	-- 	rprint(PlayerIndex, "You will now play as CIVILIANS")
	-- 	--CHOSEN_BIPEDS[get_var(PlayerIndex, "$hash")] = "civilians"
	-- 	execute_command("color "..PlayerIndex.." 0")
	-- end
end

function ownsThisCar(PlayerIndex, vehicleName) --utility function that checks if a player owns the specified car
	local checkTable = ActivePlayersOwnedCars[PlayerIndex]
	if checkTable[vehicleName] ~= nil then --if the table is nil, the player does not own the car
		--rprint(PlayerIndex, "Do you own "..vehicleName.."?")
		return true
	else
		return false
	end
end

--Define cleanup stuff in here.

function OnScriptUnload()
end

--Define your callbacks in here.

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
	register_callback(cb['EVENT_SPAWN'], "OnSpawn")
	--initalizeInventory()
end

function buyGun(PlayerIndex, gunToBuy)
	if playerIsInArea(PlayerIndex, "gunstore") then
		if gunToBuy ~= nil then
			if WEAPONS[gunToBuy] ~= nil then
				if WEAPONPRICES[gunToBuy] <= tonumber(ActivePlayers[PlayerIndex]:getBucks()) then
					local updatedWeapons = ActivePlayersOwnedWeapons[PlayerIndex]
					if updatedWeapons[gunToBuy] == nil then
						updatedWeapons[gunToBuy] = gunToBuy
						ActivePlayersOwnedWeapons[PlayerIndex] = updatedWeapons
						rprint(PlayerIndex, "You now own this weapon for loadouts.")
					end
					ActivePlayers[PlayerIndex].deductBucks(ActivePlayers[PlayerIndex], WEAPONPRICES[gunToBuy])
					giveGun(gunToBuy, PlayerIndex)
					rprint(PlayerIndex, "Purchase of "..gunToBuy.." for "..niceMoneyDisplay(WEAPONPRICES[gunToBuy]).." was successful.")
				else
					rprint(PlayerIndex, "You do not have enough bucks to buy this gun!")
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
				if VEHICLEPRICES[vehicleToBuy] ~= nil then --and it is for sale
					if VEHICLEPRICES[vehicleToBuy] <= tonumber(ActivePlayers[PlayerIndex].getBucks(ActivePlayers[PlayerIndex])) then --and the player has enough money
						--then they can buy it
							local updatedVehicles = ActivePlayersOwnedCars[PlayerIndex]
							if updatedVehicles[vehicleToBuy] == nil then
								updatedVehicles = ActivePlayersOwnedCars[PlayerIndex]
								updatedVehicles[vehicleToBuy] = vehicleToBuy
								ActivePlayersOwnedCars[PlayerIndex] = updatedVehicles						
								ActivePlayers[PlayerIndex].deductBucks(ActivePlayers[PlayerIndex], VEHICLEPRICES[vehicleToBuy])
								rprint(PlayerIndex, "Purchase of "..vehicleToBuy.." for "..niceMoneyDisplay(VEHICLEPRICES[vehicleToBuy]).." was successful.")
							else
								rprint(PlayerIndex, "You already own this vehicle!")
							end
					else
						rprint(PlayerIndex, "You do not have enough bucks to buy this vehicle!")
					end
				else
					rprint(PlayerIndex, "This vehicle is not for sale.")
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
		-- table.remove(commandargs,1)
		-- local PlayerToFine = commandargs[1]
		-- if PlayerToFine ~= nil then
		-- 	PlayerToFine = tonumber(PlayerToFine)
		-- 	table.remove(commandargs,1)
		-- 	local amountToFine = commandargs[1]
		-- 	if amountToFine ~= nil then
		-- 		amountToFine = tonumber(amountToFine)
		-- 		local bankBalance = tonumber(ActivePlayers[PlayerToFine].getBucks(ActivePlayers[PlayerToFine]))
		-- 		if bankBalance ~= nil then
		-- 			if amountToFine < bankBalance then --if the player has enough money in their bank
		-- 				ActivePlayers[PlayerToFine].deductBank(ActivePlayers[PlayerToFine], amountToFine) --then take the fine out of their bank
		-- 			else --otherwise, take it out of their bank and cash
		-- 				local cashDifference = amountToFine - bankBalance
		-- 				ActivePlayers[PlayerToFine].deductBank(ActivePlayers[PlayerToFine], amountToFine)
		-- 				ActivePlayers[PlayerToFine].deductCash(ActivePlayers[PlayerToFine], cashDifference)
		-- 			end
		-- 		else
		-- 			rprint(PlayerIndex, "Invalid fine amount specified!")
		-- 		end
		-- 	else
		-- 		rprint(PlayerIndex, "Invalid fine amount specified")
		-- 	end
		-- else
		-- 	rprint(PlayerIndex, "Invalid player index specified!")
		-- end
		rprint(PlayerIndex, "Work in progress")
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

function DriveCommand(PlayerIndex, vehicleToDrive) --Summons a specified vehicle for the player that requests it.
	if PlayerSpawnedVehicles[PlayerIndex] ~= 1 then --if the player does not have a spawned vehicle
		if playerIsInArea(PlayerIndex, "garage") then --and they are at a valid garage
			if ownsThisCar(PlayerIndex, vehicleToDrive) == true then --and they own the car they want to spawn
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

function OnAreaEnter(PlayerIndex, areaEntered)
	PlayerAreas[PlayerIndex] = areaEntered
	rprint(PlayerIndex, "You have entered "..LOCATIONS[areaEntered])
end

function OnAreaExit(PlayerIndex, areaExited)
	PlayerAreas[PlayerIndex] = ""
	rprint(PlayerIndex, "You have exited "..LOCATIONS[areaExited])
end

function OnCommand(PlayerIndex,Command,Environment,Password)
	if desync() == false then
		if player_present(PlayerIndex) then
			Command = string.lower(Command)
			local adminLevel = tonumber(get_var(PlayerIndex, "$lvl")) -- Gets player admin level
			local localPlayer = ActivePlayers[PlayerIndex]
			--rprint(PlayerIndex, "You are admin level "..adminLevel)
			commandargs = {}
			for w in Command:gmatch("%w+") do commandargs[#commandargs+1] = w end -- parses the string for spaces, and separates each word of the command into their own elements in the queue.  
			if commandargs[1] == "drive" then --/drive <car> -> summons the specified car if the player owns it.
					table.remove(commandargs, 1) --pop the first element off the command queue.
					DriveCommand(PlayerIndex, commandargs[1])
					return false
			elseif commandargs[1] == "park" then --/park -> despawns the specified car if the player owns it
					ParkCommand(PlayerIndex)
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
			elseif commandargs[1] == "save" then --/save -> writes ActivePlayers -> $hash
					writePlayerData(PlayerIndex)
					return false
			elseif commandargs[1] == "buy" then --/buy <objectToBuy> <objectName> -> allows a player to buy something.
					table.remove(commandargs, 1)
					if VEHICLEPRICES[commandargs[1]] ~= nil then
						buyVehicle(PlayerIndex, commandargs[1])
					elseif WEAPONPRICES[commandargs[1]] ~= nil then
						buyGun(PlayerIndex, commandargs[1])
					elseif commandargs[1] == "ammo" then
						if playerIsInArea(PlayerIndex, "gunstore") then
							if tonumber(localPlayer:getBucks()) >= maxAmmoPrice then--if the player has enough money
								--then allow the purchase
								localPlayer:deductBucks(maxAmmoPrice)
								execute_command("ammo "..PlayerIndex.." 999 0")
								rprint(PlayerIndex, "Purchase of max ammo for "..niceMoneyDisplay(maxAmmoPrice).." was successful.")
							else
								--otherwise tell them they do not have enough
								rprint(PlayerIndex, "You do not have enough money to buy ammo.")
							end
						else
							rprint(PlayerIndex, "You need to be at a gunstore to buy ammo.")
						end
					else
						rprint(PlayerIndex, "Invalid object specified.")
					end
					return false
			elseif commandargs[1] == "cop" then
					-- local tempCopStatus = ActivePlayers[PlayerIndex].getCopStatus(ActivePlayers[PlayerIndex])
					-- if tempCopStatus > 0 then
					-- 	table.remove(commandargs,1)
					-- 	copCommands(PlayerIndex, commandargs)
					-- else
					-- 	rprint(PlayerIndex, "You must be a cop to execute a cop command!")
					-- end
					rprint(PlayerIndex, "This command is WIP (You entered "..commandargs[1]..")")
				return false
			elseif commandargs[1] == "hirecop" then
					if adminLevel >= 4 or localPlayer:getProfession() == "sheriff" then
						table.remove(commandargs,1)
						local hiredCop = tonumber(commandargs[1])
						if player_present(hiredCop) then
							if ActivePlayers[hiredCop]:setCopPosition(tonumber(commandargs[2])) then
								rprint(hiredCop, "You are now a "..COPPOSITIONS[tonumber(commandargs[2])])
								rprint(PlayerIndex, "You have successfully changed "..ActivePlayers[hiredCop]:getName().." to be a "..COPPOSITIONS[tonumber(commandargs[2])])
								ActivePlayers[hiredCop]:setProfession(COPPOSITIONS[tonumber(commandargs[2])])
								if ActivePlayers[hiredCop]:getCopPosition() == 0 then
									rprint(PlayerIndex, "AUTHORITY LOST")
									ActivePlayers[hiredCop]:setCopAuthority(0)
								else
									rprint(PlayerIndex, "AUTHORITY GAINED")
									ActivePlayers[hiredCop]:setCopAuthority(1)
								end
							else
								rprint(PlayerIndex, "You did not specify a valid cop rank.")
							end
						else
							rprint(PlayerIndex, "This person is not active on the server right now.")
						end
					else
						rprint(PlayerIndex, "You do not have permission to hire cops!")
					end
					rprint(PlayerIndex, "This command is WIP (You entered "..commandargs[1]..")")
					return false
			elseif commandargs[1] == "testauthority" then
					if localPlayer:getCopAuthority() == 1 then
						rprint(PlayerIndex, "You have authority.")
					else
						rprint(PlayerIndex, "You do not have authority")
					end
					return false
			elseif commandargs[1] == "showid" then
					ShowIDFunction(PlayerIndex)
					return false
			elseif commandargs[1] == "drop" then
					drop_weapon(PlayerIndex)
					return false
			elseif commandargs[1] == "redeem" then
				if gunEvent ~= false or moneyEvent ~= false or carEvent ~= false then
					table.remove(commandargs,1)
					local typeOfEvent = commandargs[1]
					if typeOfEvent ~= nil then
						if typeOfEvent == "gun" and gunEvent ~= false then
							if playerIsInArea(PlayerIndex, "gunstore") then
								local gunToGive = spawn_object("weapon", WEAPONS[freeGun])
								assign_weapon(gunToGive, PlayerIndex)
								rprint(PlayerIndex, "You have successfully redeemed a "..freeGun.."!")
							else
								rprint(PlayerIndex, "You must be at a gun store to redeem this item.")
							end
						elseif typeOfEvent == "money" and moneyEvent ~= false then
							if ClaimedRewards[get_var(PlayerIndex, "$hash")] == nil then
								rprint(PlayerIndex, "Congratulations. You just earned free money!")
								ActivePlayers[PlayerIndex]:payBucks(freeMoney)
								ClaimedRewards[get_var(PlayerIndex, "$hash")] = get_var(PlayerIndex, "$hash")
							else
								rprint(PlayerIndex, "You have already claimed this reward!")
							end
						elseif typeOfEvent == "car" and carEvent ~= false then
							if playerIsInArea(PlayerIndex, "dealership") then
								local updatedVehicles = ActivePlayersOwnedCars[PlayerIndex]
								if updatedVehicles[freeCar] == nil then
									updatedVehicles[freeCar] = freeCar
									ActivePlayersOwnedCars[PlayerIndex] = updatedVehicles
									rprint(PlayerIndex, "You have successfully redeemed a "..freeCar.."!")
								else
									rprint(PlayerIndex, "You already own this vehicle!")
								end
							else
								rprint(PlayerIndex, "You must be at a dealership in order to redeem this vehicle.")
							end
						else
							rprint(PlayerIndex, "You did not specify a correct redemption value, OR")
							rprint(PlayerIndex, "That specific event is not activated.")
						end
					else
						rprint(PlayerIndex, "You did not specify a redemption value!")
					end
				else
					rprint(PlayerIndex, "There is currently no active freebe events.")
				end
				return false
			elseif commandargs[1] == "activateevent" then
				if adminLevel >= 4 then
					table.remove(commandargs,1)
					local typeOfEvent = commandargs[1]
					if typeOfEvent ~= nil then
						if typeOfEvent == "gun" and gunEvent == false then
							say_all("A GUN Event has been activated.")
							say_all("Head to the gun store to redeem a free gun!")
							gunEvent = true
						elseif typeOfEvent == "car" and carEvent == false then
							say_all("A CAR Event has been activated.")
							say_all("Head to the dealership to redeem a free car!")
							carEvent = true
						elseif typeOfEvent == "money" and moneyEvent == false then
							say_all("A MONEY event has been activated.")
							say_all ("Type in /redeem money ANYWHERE to get free money!")
							moneyEvent = true
						else
							rprint(PlayerIndex, "You did not specify a valid event! OR")
							rprint(PlayerIndex, "That event has already been activated!")
						end
					else
						rprint(PlayerIndex, "You did not specify the type of event to activate!")
					end		
				else
					rprint(PlayerIndex, "You cannot activate a redemption event.")
				end
				return false
			elseif commandargs[1] == "check" then
				table.remove(commandargs,1)
				if #commandargs == 0 then
					rprint(PlayerIndex, "You need to specify what you want to check!")
				elseif commandargs[1] == "loadout" then
					rprint(PlayerIndex, "Primary Weapon: "..localPlayer:getPrimaryWeapon())
					rprint(PlayerIndex, "Secondary Weapon: "..localPlayer:getSecondaryWeapon())
				elseif commandargs[1] == "job" then
					if localPlayer.professionLimit ~= 0 then
						rprint(PlayerIndex, "You are a"..localPlayer:getProfession())
					end
				elseif commandargs[1] == "rank" then
					local rankNumber = localPlayer:getCopRank()
					if rankNumber == 0 then
						rprint(PlayerIndex, "You are not a cop.")
					elseif rankNumber == 1 then
						rprint(PlayerIndex, "Deputy")
					elseif rankNumber == 2 then
						rprint(PlayerIndex, "Sheriff")
					end
				elseif commandargs[1] == "stats" then
					rprint(PlayerIndex, "Player Statistics for: "..ActivePlayers[PlayerIndex]:getName())
					rprint(PlayerIndex, "You are a "..ActivePlayers[PlayerIndex]:getProfession())
					rprint(PlayerIndex, "You have "..ActivePlayers[PlayerIndex]:getKarma().." karma points.")
				elseif commandargs[1] == "all" then
					rprint(PlayerIndex, "name: "..ActivePlayers[PlayerIndex]:getName())
					rprint(PlayerIndex, "hash: "..ActivePlayers[PlayerIndex]:getHash())
					rprint(PlayerIndex, "bucks: "..ActivePlayers[PlayerIndex]:getBucks())
					rprint(PlayerIndex, "profession: "..ActivePlayers[PlayerIndex]:getProfession())
					rprint(PlayerIndex, "apartment: "..ActivePlayers[PlayerIndex]:getApartment())
					rprint(PlayerIndex, "cop position: "..ActivePlayers[PlayerIndex]:getCopPosition().." ("..COPPOSITIONS[ActivePlayers[PlayerIndex]:getCopPosition()]..")")
					rprint(PlayerIndex, "authority: "..ActivePlayers[PlayerIndex]:getCopAuthority())
					rprint(PlayerIndex, "fugitive status: "..ActivePlayers[PlayerIndex]:getFugitiveStatus())
					rprint(PlayerIndex, "karma: "..ActivePlayers[PlayerIndex]:getKarma())
					rprint(PlayerIndex, "primary weapon: "..ActivePlayers[PlayerIndex]:getPrimaryWeapon())
					rprint(PlayerIndex, "secondary weapon: "..ActivePlayers[PlayerIndex]:getSecondaryWeapon())
					rprint(PlayerIndex, "jail status: "..ActivePlayers[PlayerIndex]:getJailStatus())
				end
				return false
			elseif commandargs[1] == "wallet" then --/checkstatus -> debug function
				local aTable = ActivePlayers[PlayerIndex]
				rprint(PlayerIndex, "Wallet: "..niceMoneyDisplay(localPlayer:getBucks()))
				return false
			elseif commandargs[1] == "loadout" then
				if playerIsInArea(PlayerIndex, "gunstore") then
					local ownedWeapons = ActivePlayersOwnedWeapons[PlayerIndex]
					if tonumber(ActivePlayers[PlayerIndex]:getBucks()) >= loadoutChangePrice then
						if ownedWeapons[commandargs[2]] == nil  and ownedWeapons[commandargs[3]] == nil then
							rprint(PlayerIndex, "Loadout command was not issued correctly.")
							rprint(PlayerIndex, "You specified one or more weapons you do not own.")
						else
							localPlayer:deductBucks(loadoutChangePrice)
							localPlayer:setLoadoutPrimary(commandargs[2])
							localPlayer:setLoadoutSecondary(commandargs[3])
							rprint(PlayerIndex, "You have successfully changed your loadout for "..niceMoneyDisplay(loadoutChangePrice))
							rprint(PlayerIndex, "Primary: "..localPlayer:getPrimaryWeapon()..", Secondary: "..localPlayer:getSecondaryWeapon())
						end
					else
						rprint(PlayerIndex, "You do not have enough bucks to change your loadout.")
					end
				else
					rprint(PlayerIndex, "You must be at a gunstore to change your loadout.")
				end		
				return false
			elseif commandargs[1] == "owned" then
				table.remove(commandargs,1)
				if commandargs[1] == "cars" or commandargs[1] == "vehicles" then
					rprint(PlayerIndex, "You own the following cars: ")
					local vehicleTable = ActivePlayersOwnedCars[PlayerIndex]
					for vehicleName, veh in pairs(vehicleTable) do
						rprint(PlayerIndex, vehicleName)
					end
				elseif commandargs[1] == "guns" or commandargs[1] == "weapons" then
					rprint(PlayerIndex, "You own the following weapons: ")
					local weaponTable = ActivePlayersOwnedWeapons[PlayerIndex]
					for weaponName, veh in pairs(weaponTable) do
						rprint(PlayerIndex, weaponName)
					end
				end
				return false
			elseif commandargs[1] == "betatester" then
				-- localPlayer:setBucks(15000)
				-- rprint(PlayerIndex, "Be Careful! This will SET your bucks to 15,000!")
				return false
			end
		end
	else
		rprint(PlayerIndex, "You cannot issue a command while the server is desynced!")
	end
end 

function OnError(message)
	say_all("error was called")
	for i=0, 16 do
		if tonumber(get_var(i, "$lvl")) > 1 then -- Gets player admin level
			rprint(i, message)
		end
	end
	local file = io.open("errors.txt", "a")
	file:write(message)
	file:write("\n")
	file:close()
end

function OnGameEnd()
    OnGameEnd = OnScriptUnload
end

function OnGameStart()
	--gameStartSequence()
	print("Starting game...")
end

function OnKill(PlayerIndex, VictimIndex) --if a player kills someone
	rprint(PlayerIndex, "You earned money!")
	rprint(VictimIndex, "You lost money!")
	VictimIndex = tonumber(VictimIndex)
	local droppedCash = ActivePlayers[VictimIndex].getBucks(ActivePlayers[VictimIndex])
	ActivePlayers[PlayerIndex]:setFugitiveStatus(1)
	if tonumber(ActivePlayers[VictimIndex]:getCopRank()) > 0 then
		rprint(PlayerIndex, "You just killed a cop!")
	else
		rprint(PlayerIndex, "You just killed someone!")
	end
	ActivePlayers[PlayerIndex].payBucks(ActivePlayers[PlayerIndex], 100)
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

function OnPlayerDie(PlayerIndex, message)
	execute_command("vdel " .. PlayerIndex)
	PlayerIsInAVehicle[PlayerIndex] = 0
	PlayerSpawnedVehicles[PlayerIndex] = 0
	-- setColor(PlayerIndex)
end

function OnPlayerJoin(PlayerIndex)
	getPlayerData(PlayerIndex)
end

function OnPlayerLeave(PlayerIndex)
	execute_command("vdel " .. PlayerIndex)
	PlayerIsInAVehicle[PlayerIndex] = 0
	PlayerSpawnedVehicles[PlayerIndex] = 0
	writePlayerData(PlayerIndex)
	local emptyInventory = Inventory:new(Inventory)
	local emptyVehicleTable = {}
	ActivePlayers[PlayerIndex] = emptyInventory
	ActivePlayersOwnedCars[PlayerIndex] = emptyVehicleTable
end

function OnSpawn(PlayerIndex)
	print("*********************OnSpawn called")
	if ActivePlayers[PlayerIndex]:getPrimaryWeapon() ~= "empty" and ActivePlayers[PlayerIndex]:getSecondaryWeapon() ~= "empty" then
		print("SETTING GUNS")
		giveGun(ActivePlayers[PlayerIndex]:getSecondaryWeapon(), PlayerIndex)
		giveGun(ActivePlayers[PlayerIndex]:getPrimaryWeapon(), PlayerIndex)
	end
end

function OnSuicide(PlayerIndex)
	rprint(PlayerIndex, "Why'd you kill yourself dum dum?!?")
end

function OnTick()
	if waitingToReward > timeToReward then
		AlertServer(nil, "Welfare has been distributed!")
		for i=1, 16 do
			if ActivePlayers[i] ~= nil then
				ActivePlayers[i].payBucks(ActivePlayers[i], 1500) --NEEDS TO BE CHANGED.
			end
		end
		waitingToReward = 0
	else
		waitingToReward = waitingToReward + 1
	end
end

function OnVehicleEnter(PlayerIndex)
	PlayerIsInAVehicle[PlayerIndex] = 1
end

function OnVehicleExit(PlayerIndex)
	PlayerIsInAVehicle[PlayerIndex] = 0
end

