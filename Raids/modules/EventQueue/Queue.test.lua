queue = require 'Queue'


myQueue = queue:new()
myQueue:push(1)
myQueue:push(2)
myQueue:push(3)
print(myQueue:peek())
myQueue:pop()
print(myQueue:peek())
myQueue:pop()
print(myQueue:peek())
myQueue:pop()

