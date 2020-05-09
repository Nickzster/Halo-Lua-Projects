print("Hello, lua!")

table = {
    ['hello'] = function(name) print("Hello, " .. name .."!") end,
}

table['goodbye'] = function(name) print("Goodbye, " .. name .. "!") end

table.hello('Nick')
table.goodbye('Nick')