api_version = "1.10.1.0"

--Implement any global modules, tables, or values in this file or within this directory.

--Implement any utility / interfacing function within this file, or in this directory.

--Modules.
--You can implement any modules or components that you will need, within this file or within this directory.

--Implement your callbacks in here.
--You can also implement them in separate files, within the callback directory.


--Main.
--Define your callbacks here, and do your clean up in here.

function OnScriptLoad()
    register_callback(cb['EVENT_COMMAND'],"OnCommand")
end

function OnScriptUnload()
end

function OnError(message)
    print(message)
end

function OnCommand(PlayerIndex,Command,Environment,Password)
    say(PlayerIndex, "You just executed a command!")
end


--End of build file.