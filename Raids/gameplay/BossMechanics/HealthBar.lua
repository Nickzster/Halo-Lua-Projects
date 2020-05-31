-- BEGIN_IMPORT
-- import Raids.classes.Boss end
-- import Raids.globals.values end
-- END_IMPORT

function ClearConsole(i)
	for j=0,25 do
		rprint(i, " ")
	end
end

function PrintHealthBar(currentHealth, maxHealth)
    local length = 65
	if currentHealth == -100 then
		currentHealth = maxHealth
	end
	local healthBar = ""
	for i=1,length do
		if i > currentHealth/maxHealth*length then
			healthBar = healthBar.."."
		else
    		healthBar = healthBar.."|"
		end
	end
	return healthBar
end

function pickColor(health, maxHealth)
    local healthRatio = health / maxHealth
    if healthRatio >= 0.75 then
        return "|nc15B500" --green
    elseif healthRatio >= 0.5 and healthRatio < 0.75 then
        return "|ncDBC900" --yellow
    elseif healthRatio >= 0.25 and healthRatio < 0.5 then
        return "|ncFC8003" --orange
    else
        return "|ncFC0303" --red
    end
end

function PrintBossBar()
    for key,_ in pairs(ACTIVE_BOSSES) do
        local currentBoss = ACTIVE_BOSSES[key]
        local currentBossInMemory = get_dynamic_player(key) 
        local currentBossMaxHealth = currentBoss:getArmor():getMaxHealth()
        local currentBossHealth = 0
        if currentBossInMemory ~= 0 then
            currentBossHealth = read_float(currentBossInMemory + 0xE0)*currentBoss:getArmor():getMaxHealth()
        end
        local chosenColor = pickColor(currentBossHealth, currentBossMaxHealth)
        if player_alive(key) then
            for i=1,16 do
                if get_var(0, "$ticks")%5 == 1 then
                    if player_present(i) then
                        ClearConsole(i)
                        rprint(i, "|c"..string.upper(currentBoss:getArmor():getName(), "$name").."'S HEALTH " .. math.floor(currentBossHealth) .. "/" .. currentBossMaxHealth ..chosenColor)
                        rprint(i, "|c<"..PrintHealthBar(currentBossHealth, currentBossMaxHealth)..">"..chosenColor)
                    end
                end
            end
        else
        end
    end
end

