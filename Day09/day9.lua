require("util")

local heightMap = {}
for line in io.lines("data") do
    local heightTable = {}
    for num in string.gmatch(line, "%d") do
        table.insert(heightTable, tonumber(num))
    end
    table.insert(heightMap, heightTable)
end

local function isLowest(i, j)
    return (not heightMap[i - 1] or heightMap[i][j] < heightMap[i - 1][j]) and
    (not heightMap[i + 1] or heightMap[i][j] < heightMap[i + 1][j]) and
    (not heightMap[i][j - 1] or heightMap[i][j] < heightMap[i][j - 1]) and
    (not heightMap[i][j + 1] or heightMap[i][j] < heightMap[i][j + 1])
end

local function checkGroup(i, j, indexTable)
    return heightMap[i] and heightMap[i][j] and heightMap[i][j] < 9 and not (indexTable[i] and indexTable[i][j])
end

local function getGroup(i, j, indexTable)
    indexTable[i] = indexTable[i] or {}
    indexTable[i][j] = 1

    if checkGroup(i - 1,j, indexTable) then
        getGroup(i - 1, j, indexTable)
    end
    if checkGroup(i + 1,j,indexTable) then
        getGroup(i + 1, j, indexTable)
    end
    if checkGroup(i, j - 1,indexTable) then
        getGroup(i, j - 1, indexTable)
    end
    if checkGroup(i, j + 1,indexTable) then
        getGroup(i, j + 1, indexTable)
    end
end

local part1Result = 0 
local part2Result = 0
local max1 = 0
local max2 = 0
local max3 = 0
for i = 1, #heightMap do
    for j = 1, #(heightMap[1]) do
        if isLowest(i, j) then
            part1Result = part1Result + (heightMap[i][j] + 1)
            local indexTable = {}
            getGroup(i, j, indexTable)

            local count = 0
            for kindexTable, vindexTable in pairs(indexTable) do
                for kvindexTable, vvindexTable in pairs(vindexTable) do
                    count = count + 1
                end
            end

            if max3 < count then
                max3 = count
            end

            if max2 < max3 then
                max2 = max2 + max3
                max3 = max2 - max3
                max2 = max2 - max3 
            end

            if max1 < max2 then
                max1 = max1 + max2
                max2 = max1 - max2
                max1 = max1 - max2 
            end
        end
    end
end

print("part1Result: "..part1Result)
print("part2Result: "..(max1 * max2 * max3))
