local positionList = {}
local min = nil
local max = nil
local part2 = true

local function getStepFuel(n)
    return part2 and (n * (1 + n) / 2) or n
end

for line in io.lines("data") do
    for str in string.gmatch(line, '(%d+)') do
        local n = tonumber(str)
        if min == nil or min > n then min = n end
        if max == nil or max < n then max = n end
        table.insert(positionList, n)
    end
end

local result = nil
for i = min, max do
    local tempSum = 0
    for _, v in ipairs(positionList) do
        tempSum = tempSum + getStepFuel(math.abs(v - i))
    end

    if result == nil or tempSum < result then
        result = tempSum
    end
end

print(result)

