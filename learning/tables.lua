print("Hello, lua!")

table = {
    ['hello'] = function(name) print("Hello, " .. name .."!") end,
}

table['goodbye'] = function(name) print("Goodbye, " .. name .. "!") end

anotherTable = {
    [table] = 10
}

table.hello('Nick')
table.goodbye('Nick')

print(anotherTable[table])