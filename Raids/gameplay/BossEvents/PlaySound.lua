-- BEGIN_IMPORT
-- import Raids.globals.Dialog end
-- import Raids.modules.Events.EventItem end
-- import Raids.modules.Events.EventTable end
-- END_IMPORT

function playDialog(bossName, variant)
    if BOSS_DIALOG[bossName] == nil 
    or BOSS_DIALOG[bossName][variant] == nil 
    then 
        print("### " .. variant .. " NOT FOUND!") 
        return 
    end
    if BOSS_DIALOG[bossName][variant].played then 
        return 
    end
    local dialogToPlay = BOSS_DIALOG[bossName][variant]
    local tagref = spawn_object("vehi", 
    dialogToPlay.ref,
    dialogToPlay.loc.x,
    dialogToPlay.loc.y,
    dialogToPlay.loc.z)
    local deleteDialog = EventItem:new()
    deleteDialog:set({
        ['deleteDialog'] = tagref
    }, 
    nil,
    function(props) destroy_object(props.deleteDialog) end,
    dialogToPlay.seconds * 30)
    EventTable:addEvent(bossName .. "_" .. variant, deleteDialog)
    BOSS_DIALOG[bossName][variant].played = true
end