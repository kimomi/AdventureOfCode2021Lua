require 'util'

local function tableWin(allNumT, markNumT)
    local len = #allNumT
    for i = 1, len do
        local win = true
        for j = 1, #(allNumT[1]) do
            if not table.contains(markNumT, allNumT[i][j]) then
                win = false
                break
            end 
        end

        if win then
            return true
        end
    end

    for j = 1, #(allNumT[1]) do
        local win = true
        for i = 1, len do
            if not table.contains(markNumT, allNumT[i][j]) then
                win = false
                break
            end 
        end

        if win then
            return true
        end
    end

    return false
end

local function readNumTable(inputStr)
    local  t = {}
    for str in string.gmatch(inputStr, '(%d+)') do
        table.insert(t, tonumber(str))
    end
    return t
end

local io = require 'io'
local file = io.open('data', 'r')
local markNumStr = file:read()
local allNumTable = {}
local markNumTable = readNumTable(markNumStr)

while true do -- empty line
    local numTable = {}
    local inpuStr = file:read()
    while inpuStr and inpuStr ~= "" do
        table.insert(numTable, readNumTable(inpuStr))
        inpuStr = file:read()
    end
    if not table.empty(numTable) then
        table.insert(allNumTable, numTable) 
    end
    if not inpuStr then
        break
    end
end

file:close()

local function getEndIndex()
    local realMarkNumTable = {}
    for index = 1, #markNumTable do
        table.insert(realMarkNumTable, markNumTable[index])

        for _, realNumTable in ipairs(allNumTable) do
            if tableWin(realNumTable, realMarkNumTable) then
                return index, realNumTable, realMarkNumTable
            end
        end
    end
end

local index, board, realMarkNumTable = getEndIndex()
local sum = 0
for i, v in ipairs(board) do
    for _, vv in ipairs(v) do
        if not table.contains(realMarkNumTable, vv) then
            sum = sum + vv
        end
    end
end

print(sum * markNumTable[index])
