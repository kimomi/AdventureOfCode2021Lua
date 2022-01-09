local countTable = {}

local function getData()
    local x = 0
    for line in io.lines("data") do
        x = x + 1
        countTable[x] = {}
        local y = 0
        for numStr in string.gmatch(line, "%d") do
            y = y + 1
            countTable[x][y] = tonumber(numStr)
        end
    end
end

getData()

local function getDataPart2()
    local x = #countTable
    local y = #countTable[1]
    local size = 5
    for i = 1, x do
        for j = 1, y do
            for sizex = 0, size - 1 do
                for sizey = 0, size - 1 do
                    local realX = i + x * sizex
                    local realY = j + y * sizey
                    if not countTable[realX] then countTable[realX] = {} end
                    countTable[realX][realY] = countTable[i][j] + sizex + sizey
                    if countTable[realX][realY] > 9 then
                        countTable[realX][realY] = countTable[realX][realY] - 9
                    end
                end
            end
        end
    end
end

getDataPart2()

local riskTable = {}

local function UpdateChoiceTable(result, kx, ky)
    local x = #countTable
    local y = #countTable[1]
    if kx - 1 > 0 and (riskTable[kx - 1] == nil or riskTable[kx - 1][ky] == nil) then
        if not result[kx - 1] then
            result[kx - 1] = {}
        end
        result[kx - 1][ky] = countTable[kx - 1][ky]
    end

    if kx + 1 <= x and (riskTable[kx + 1] == nil or riskTable[kx + 1][ky] == nil) then
        if not result[kx + 1] then
            result[kx + 1] = {}
        end
        result[kx + 1][ky] = countTable[kx + 1][ky]
    end

    if ky - 1 > 0 and riskTable[kx][ky - 1] == nil then
        if not result[kx] then
            result[kx] = {}
        end
        result[kx][ky - 1] = countTable[kx][ky - 1]
    end

    if ky + 1 <= y and riskTable[kx][ky + 1] == nil then
        if not result[kx] then
            result[kx] = {}
        end
        result[kx][ky + 1] = countTable[kx][ky + 1]
    end
end

local function GetRiskNum(kx ,ky)
    local x = #countTable
    local y = #countTable[1]
    local min
    if (kx - 1 > 0 and riskTable[kx - 1] and riskTable[kx - 1][ky]) then
        if min == nil or min > riskTable[kx - 1][ky] then
            min = riskTable[kx - 1][ky]
        end
    end

    if (kx + 1 <= x and riskTable[kx + 1] and riskTable[kx + 1][ky]) then
        if min == nil or min > riskTable[kx + 1][ky] then
            min = riskTable[kx + 1][ky]
        end
    end

    if (ky - 1 > 0 and riskTable[kx] and riskTable[kx][ky - 1]) then
        if min == nil or min > riskTable[kx][ky - 1] then
            min = riskTable[kx][ky - 1]
        end
    end

    if (ky + 1 <= y and riskTable[kx] and riskTable[kx][ky + 1]) then
        if min == nil or min > riskTable[kx][ky + 1] then
            min = riskTable[kx][ky + 1]
        end
    end

    return min + countTable[kx][ky]
end

riskTable[1] = {}
riskTable[1][1] = 0
local choiceTable = {}
UpdateChoiceTable(choiceTable, 1, 1)
while (riskTable[#countTable] == nil or riskTable[#countTable][#countTable[1]] == nil) do
    local minX, minY, minCount
    for x, valueTable in pairs(choiceTable) do
        for y, v in pairs(valueTable) do
            local riskNum = GetRiskNum(x, y)
            if minCount == nil or riskNum < minCount then
                minCount = riskNum
                minX = x
                minY = y
            end
        end
    end

    if not riskTable[minX] then
        riskTable[minX] = {}
    end
    riskTable[minX][minY] = minCount

    -- update choiceTable
    choiceTable[minX][minY] = nil
    UpdateChoiceTable(choiceTable, minX, minY)

    -- print("x:" .. tostring(minX) .. ", y:" .. tostring(minY) .. ", value:" ..tostring(riskTable[minX][minY]))
end

print("Result: " .. riskTable[#countTable][#countTable[#countTable]])
