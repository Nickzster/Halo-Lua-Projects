Table = {
    name = "My First Table",
    value = 42
}

AnotherTable = {
    name = "My Second Table",
    value = 24,
    val = "bar",
    display = function() return self.val end --does not work
}

AnotherTable.__index = function(_, key) return AnotherTable[key] end


setmetatable(Table, AnotherTable)

print(Table.fuck)
print(Table.display)