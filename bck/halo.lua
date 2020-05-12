
local callbacks = require('./modules/callbacks.lua')

function MyCommand(PlayerIndex,Command,Environment,Password)
    say(PlayerIndex,"You just executed a command!")
end

function OnScriptLoad()
	register_callback(cb['EVENT_COMMAND'],"MyCommand")
end