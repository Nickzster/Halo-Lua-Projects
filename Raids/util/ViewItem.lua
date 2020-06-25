-- BEGIN_IMPORT
-- import Raids.globals.RaidItems end
-- END_IMPORT

function ViewItem(item, playerIndex)
    rprint(playerIndex, "|c --------------------------------------------------------------- |nc00b3ff")
    local type = item['type']
    rprint(playerIndex, "|c Name: " .. item['pretty'] .. "|nc00b3ff" )
    rprint(playerIndex, "|c Type: " .. type .. "|nc00b3ff")
    rprint(playerIndex, "|c Description: " .. item['description'] .. "|nc00b3ff")
    if type == 'WEAPON' then
        rprint(playerIndex, "|c Max Ammo: " .. item['maxAmmo'] .. "|nc00b3ff")
    elseif type=="ARMOR" then
        rprint(playerIndex, "|c Max Health: " .. item['maxHealth'] .. "| Defense: " .. item['defense'] .. "|nc00b3ff")
    elseif type == 'DAMAGE_BOOST' or type == "DAMAGE_REDUCE" then
        rprint(playerIndex, "|c Modifier: x" .. item['modifier'] .. "|nc00b3ff")
    elseif type == "DAMAGE_CRIT_STRIKE" then
        rprint(playerIndex, "|c RNG Value: " .. item['rng'] .. "|nc00b3ff")
        rprint(playerIndex, "|c Damage Modifier: x" .. item['modifier'] .. "|nc00b3ff")
    elseif type == "DAMAGE_IGNORE" then
        rprint(playerIndex, "|c RNG Value: " .. item['rng'] .. "|nc00b3ff")
    elseif type == "BOSS" then
        rprint(playerIndex, "|c Defense: " .. item['defense'] .. " | X Small Raid: " .. item['maxHealth']*1.0 .. "|nc00b3ff")
        rprint(playerIndex, "|c Small Raid: " .. item['maxHealth']*1.5 .. " | Medium Raid: " .. item['maxHealth']*2.5 .. "|nc00b3ff" )
        rprint(playerIndex, "|c Large Raid: " .. item['maxHealth']*3.75 .. " | X Large Raid:  " .. item['maxHealth']*5.0 .. "|nc00b3ff" )
    end
    rprint(playerIndex, "|c --------------------------------------------------------------- |nc00b3ff")
end