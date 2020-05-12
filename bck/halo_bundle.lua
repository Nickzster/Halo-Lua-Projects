__luapack_modules__ = {
    (function()
        local callbacks = {}
        
        local function callbacks.OnCommand(PlayerIndex,Command,Environment,Password)
            say(PlayerIndex,"You just executed a command!")
        end
        
    return callbacks
    end),

}
__luapack_cache__ = {}
__luapack_require__ = function(idx) 
    local cache = __luapack_cache__[idx]
    if cache then
        return cache
    end

    local module = __luapack_modules__[idx]()
    __luapack_cache__[idx] = module
    return module
end


local callbacks = __luapack_require__(1)


function MyCommand(PlayerIndex,Command,Environment,Password)
    say(PlayerIndex,"You just executed a command!")
end

function OnScriptLoad()
	register_callback(cb['EVENT_COMMAND'],"MyCommand")
	--initalizePocket()
end