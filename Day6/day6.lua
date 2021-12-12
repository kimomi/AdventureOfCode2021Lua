local fishTable = {}
for line in io.lines("data") do
    for str in string.gmatch(line, '(%d+)') do
        table.insert(fishTable, tonumber(str))
    end
end

local maxTimer = 6
local newTimer = 8

for i = 1, 80 do
    local newFishTable = {}
    for index in ipairs(fishTable) do
        fishTable[index] = fishTable[index] - 1
        newFishTable[index] = fishTable[index]
    end

    for index in ipairs(fishTable) do
        if fishTable[index] < 0 then
            newFishTable[index] = maxTimer
            table.insert(newFishTable, newTimer)
        end
    end

    fishTable = newFishTable
end

print(#fishTable)