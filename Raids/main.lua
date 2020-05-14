-- BEGIN_IMPORT
-- import Raids.src.modules.Classes.functions end
-- END_IMPORT

--Callbacks
function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    print("# # # Callbacks registered successfully!")
end


function handleCommand(playerIndex, Command, Env, RconPassword ) --number, string, number, string
    say(playerIndex, "Welcome to the server!")
end