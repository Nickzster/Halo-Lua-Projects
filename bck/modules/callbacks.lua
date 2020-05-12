local callbacks = {}

local function callbacks.OnCommand(PlayerIndex,Command,Environment,Password)
    rprint(PlayerIndex,"You just executed a command!")
end

return callbacks