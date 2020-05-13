api_version = "1.10.1.0"
--Callbacks

myPrint = require "Print"



function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    print("# # # Callbacks registered successfully!")
end


function handleCommand(playerIndex, Command, Env, RconPassword ) --number, string, number, string
    myPrint(playerIndex, "Hello there!")
end
