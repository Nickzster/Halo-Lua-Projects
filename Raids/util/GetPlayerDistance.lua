-- NO_IMPORTS

function GetPlayerDistance(index1, index2)
	local p1 = get_dynamic_player(index1)
	local p2 = get_dynamic_player(index2)
	
	return math.sqrt((read_float(p2+0x5C  ) - read_float(p1+0x5C  ))^2
	                +(read_float(p2+0x5C+4) - read_float(p1+0x5C+4))^2
	                +(read_float(p2+0x5C+8) - read_float(p1+0x5C+8))^2)
end