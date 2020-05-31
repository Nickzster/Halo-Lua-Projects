-- BEGIN_IMPORT
-- import Raids.globals.RaidItems end
-- import Raids.util.FindBipedTag end
-- END_IMPORT

function loadBipeds()
    --Load in Biped Table
    for key,_ in pairs(ITEM_LIST) do
        if ITEM_LIST[key].type == "ARMOR" or ITEM_LIST[key].type == "BOSS" then
            BIPED_TAG_LIST[key] = FindBipedTag(ITEM_LIST[key].ref)
        end
    end
    --Load in default biped
    local tag_array = read_dword(0x40440000)
    for i=0,read_word(0x4044000C)-1 do
        local tag = tag_array + i * 0x20
        if(read_dword(tag) == 1835103335 and read_string(read_dword(tag + 0x10)) == "globals\\globals") then
            local tag_data = read_dword(tag + 0x14)
            local mp_info = read_dword(tag_data + 0x164 + 4)
            for j=0,read_dword(tag_data + 0x164)-1 do
                BIPED_TAG_LIST['DEFAULT'] = read_dword(mp_info + j * 160 + 0x10 + 0xC)
            end
        end
    end
end