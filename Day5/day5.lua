local io = require("io")

local partTwo = true
local numTable = {}
for line in io.lines("data") do
    local p = {}
    for str in string.gmatch(line, '(%d+)') do
        table.insert(p, tonumber(str))
    end
    
    if p[1] == p[3] then
        local x = p[1]
        local min = p[2] > p[4] and p[4] or p[2]
        local max = p[2] + p[4] - min
        for y = min, max do
            numTable[x] = numTable[x] or {}
            numTable[x][y] = numTable[x][y] or 0
            numTable[x][y] = numTable[x][y] + 1
        end
    elseif p[2] == p[4] then
        local y = p[2]
        local min = p[1] > p[3] and p[3] or p[1]
        local max = p[1] + p[3] - min
        for x = min, max do
            numTable[x] = numTable[x] or {}
            numTable[x][y] = numTable[x][y] or 0
            numTable[x][y] = numTable[x][y] + 1
        end
    elseif partTwo and math.abs(p[2] - p[4]) == math.abs(p[3] - p[1]) then
        local p0x = p[1];
        local p0y = p[2];
        for i = 0, math.abs(p[3] - p[1]) do
            local dx = p[3] - p[1] > 0 and 1 or -1
            local dy = p[4] - p[2] > 0 and 1 or -1
            local x = p0x + i * dx;
            local y = p0y + i * dy;
            numTable[x] = numTable[x] or {}
            numTable[x][y] = numTable[x][y] or 0
            numTable[x][y] = numTable[x][y] + 1
        end
    end
end

local result = 0
for _, yList in pairs(numTable) do
    for key, value in pairs(yList) do
        if (value >= 2) then
            result = result + 1
        end
    end
end

print(result)
