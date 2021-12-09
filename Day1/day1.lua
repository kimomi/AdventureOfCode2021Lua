local io = require 'io'

local count = 0
local pre = 9999999
for line in io.lines('data') do
    local cur = tonumber(line)
    if cur > pre then
        count = count + 1
    end
    pre = cur
end

print(count)