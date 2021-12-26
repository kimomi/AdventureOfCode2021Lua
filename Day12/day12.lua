require("util")
local pathTable = {}
local resultList = {}

for line in io.lines("data") do
    local node1
    for node in string.gmatch(line, "%a+") do
        if node1 == nil then
            node1 = node
        else
            pathTable[node] = pathTable[node] or {}
            table.insert(pathTable[node], node1)

            pathTable[node1] = pathTable[node1] or {}
            table.insert(pathTable[node1], node)
        end
    end
end

-- print(table.tostring(pathTable, "pathTable"))

-- recurisve modify result table
local function checkTableValid(t, c)
    -- return not (string.lower(c) == c and table.contains(t, c))
    if c == "start" then 
        return false
    end

    if string.lower(c) ~= c then
        return true
    end

    local tableLower = {}
    tableLower[c] = 1
    local max2 = false
    for index, value in ipairs(t) do
        if string.lower(value) == value then
            tableLower[value] = (tableLower[value] or 0) + 1
            if tableLower[value] > 1 then
                if not max2 then
                    max2 = true
                else
                    return false
                end
            end
        end
    end

    return true
end

local function getPath(preList, startStr, endStr)
    preList = preList or {"start"}
    -- print(table.tostring(preList, "preList"))
    startStr = startStr or "start"
    endStr = endStr or "end"

    local result = {}
    for _, v in ipairs(pathTable[startStr]) do
        if v == endStr then
            table.insert(result, {startStr, v})
        elseif checkTableValid(preList, v) then
            local r = getPath(table.add(preList, {v}), v, endStr)
            for _, path in ipairs(r) do
                if not table.empty(path) then
                    table.insert(result, table.add({startStr}, path))
                end
            end
        end
    end

    return result
end

local part1result = getPath()
print("part1result: " .. #part1result)
-- local part2result = getPath()
-- print("part2result: " .. #part2result)
