local io = require 'io'

local totalNum = 0
local oneNum = {}
for line in io.lines('data') do
    local len = string.len(line)
    for i = 1, len do
        if string.sub(line, i, i) == '1' then
            oneNum[i] = (oneNum[i] or 0) + 1
        end
    end
    totalNum = totalNum + 1
end


local gamma = 0
local epslion = 0
for _, v in ipairs(oneNum) do
    if v > totalNum / 2 then
        gamma = gamma * 2 + 1
        epslion = epslion * 2
    else
        gamma = gamma * 2
        epslion = epslion * 2 + 1
    end
end

print(gamma * epslion)
