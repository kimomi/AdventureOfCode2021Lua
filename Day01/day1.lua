local io = require 'io'

local newNumTable = {}
local n1 = nil
local n2 = nil
local n3 = nil
for line in io.lines('data') do
    local cur = tonumber(line)
    n1 = n2
    n2 = n3
    n3 = cur

    if (n1 and n2 and n3) then
        table.insert(newNumTable, n1 + n2 + n3)
    end
end

local count = 0
local pre = nil
for _, cur in ipairs(newNumTable) do
    if pre and cur > pre then
        count = count + 1
    end
    pre = cur
end

print(count)