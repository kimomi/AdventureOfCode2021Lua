local inputTable = {}
local inputTableChangeMark = {}
for line in io.lines("data") do
    local t = {}
    local tmark = {}
    for c in string.gmatch(line, "%d") do
        table.insert(t, tonumber(c))
        table.insert(tmark, false)
    end
    table.insert(inputTable, t)
    table.insert(inputTableChangeMark, tmark)
end

local function printTable()
    for i = 1, #inputTable do
        local printLine = ""
        for j = 1, #(inputTable[i]) do
            printLine = printLine .. inputTable[i][j]
        end
        print(printLine)
    end
end


local function updateTable(i, j) 
    if inputTableChangeMark[i][j] then
        return
    end

    if inputTable[i][j] < 9 then   
        inputTable[i][j] = inputTable[i][j] + 1
    else
        inputTable[i][j] = 0
        inputTableChangeMark[i][j] = true

        for x = i - 1, i + 1 do
            if inputTable[x] then
                for y = j - 1, j + 1 do
                    if inputTable[x][y] and not (x == i and y == j) then
                        updateTable(x, y)
                    end
                end
            end
        end
    end
end

local part1Result = 0
local part2Result
local count = 0
while not part2Result do
    count = count + 1
    for i = 1, #inputTable do
        for j = 1, #(inputTable[i]) do
            updateTable(i, j)
        end
    end 

    local allFlash = true
    for i = 1, #inputTableChangeMark do
        for j = 1, #(inputTable[i]) do
            if inputTableChangeMark[i][j] then
                part1Result = part1Result + 1
                inputTableChangeMark[i][j] = false
            else
                allFlash = false
            end
        end
    end 

    if allFlash and part2Result == nil then
        part2Result = count
    end
end

-- print("part1Result: " .. part1Result)
print("part2Result: " .. part2Result)
