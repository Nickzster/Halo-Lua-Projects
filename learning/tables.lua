print("Hello, lua!")

table = {
    ['hello'] = function(name) print("Hello, " .. name .."!") end,
}

goodbyeFunction = function(name) print ("Goodbye, " .. name .."!") end

table['goodbye'] = goodbyeFunction

anotherTable = {
    [table] = 10
}

table.hello('Nick')
table.goodbye('Nick')

print(anotherTable[table])