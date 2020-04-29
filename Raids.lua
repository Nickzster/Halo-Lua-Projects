api_version = "1.10.1.0"
--Callbacks

function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'], "handleCommand")
    print("# # # Callbacks registered successfully!")
end


function handleCommand(playerIndex, Command, Env, RconPassword ) --number, string, number, string
    say(playerIndex, "Welcome to the server!")
end