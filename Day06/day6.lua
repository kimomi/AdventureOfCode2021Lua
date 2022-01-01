local fishTimerTable = {}
for line in io.lines("data") do
    for str in string.gmatch(line, '(%d+)') do
        local timer = tonumber(str)
        fishTimerTable[timer] = (fishTimerTable[timer] or 0) + 1
    end
end

local maxTimer = 6
local newTimer = 8

for i = 1, 256 do
    local newFishTable = {}
    for timer, num in pairs(fishTimerTable) do
        if (timer - 1 < 0) then
            newFishTable[maxTimer] = (newFishTable[maxTimer] or 0) + num
            newFishTable[newTimer] = num
        else
            newFishTable[timer - 1] = (newFishTable[timer - 1] or 0) + num
        end
    end

    fishTimerTable = newFishTable
end

local result = 0
for k, v in pairs(fishTimerTable) do
    result = result + v
end
print(result)