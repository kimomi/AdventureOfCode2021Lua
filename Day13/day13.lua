require("util")
local pointTable = {}
local foldList = {}

for line in io.lines("data") do
    if string.match(line, "fold along .+") then
        if string.match(line, "fold along x=.*") then
            table.insert(foldList, tonumber(string.match(line, "%d+")))
        else
            table.insert(foldList, - tonumber(string.match(line, "%d+")))
        end
    elseif string.match(line, "%d+,%d+") then
        local x, y
        for num in string.gmatch(line, "%d+") do
            if not x then
                x = tonumber(num)
            else
                y = tonumber(num)
            end
        end
        pointTable[x] = pointTable[x] or {}
        pointTable[x][y] = true
    end
end

local lastX, lastY, part1Result
for _, foldLine in ipairs(foldList) do
    if foldLine < 0 then
        lastY = -foldLine
        local newPointTable = {}
        for x, xTable in pairs(pointTable) do
            for y, value in pairs(xTable) do
                if y ~= - foldLine then
                    local newY = y
                    if y > - foldLine then 
                        newY = - 2 * foldLine - y
                    end
                    newPointTable[x] = newPointTable[x] or {}
                    newPointTable[x][newY] = true
                end
            end
        end
        pointTable = newPointTable
    else
        lastX = foldLine
        local newPointTable = {}
        for x, xTable in pairs(pointTable) do
            for y, value in pairs(xTable) do
                if x ~= foldLine then
                    local newX = x
                    if x > foldLine then 
                        newX = 2 * foldLine - x
                    end
                    newPointTable[newX] = newPointTable[newX] or {}
                    newPointTable[newX][y] = true 
                end
            end
        end
        pointTable = newPointTable
    end

    if not part1Result then
        local count = 0
        for x, xTable in pairs(pointTable) do
            for y, value in pairs(xTable) do
                count = count + 1
            end
        end
        part1Result = count
    end
end


print("part1Result: " .. part1Result)

for y = 0, lastY - 1 do
    local printLine = ""
    for x = 0, lastX - 1 do
        if pointTable[x] and pointTable[x][y] then
            printLine = printLine .. "#"
        else
            printLine = printLine .. " "
        end
    end
    print(printLine)
end
