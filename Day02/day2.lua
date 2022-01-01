local io = require 'io'

local function solution1()
    local x = 0
    local y = 0
    for line in io.lines('data') do
        for k, num in string.gmatch(line, "(%a+) (%d+)") do
            if k == "down" then
                y = y + tostring(num)
            elseif k == "up" then
                y = y - tostring(num)
            elseif k == "forward" then
                x = x + tostring(num)
            else
                error("unexpect type:" .. k)
            end
        end
    end
    
    print(x * y)
end

local function solution2()
    local x = 0
    local y = 0
    local aim = 0
    for line in io.lines('data') do
        for k, num in string.gmatch(line, "(%a+) (%d+)") do
            if k == "down" then
                aim = aim + tostring(num)
            elseif k == "up" then
                aim = aim - tostring(num)
            elseif k == "forward" then
                local n = tostring(num)
                x = x + n
                y = y + aim * n
            else
                error("unexpect type:" .. k)
            end
        end
    end

    print(x * y)
end

solution2()
