require("util")
local elementTable
local pairInsertion = {}

local function ReadInputData()

    for line in io.lines("data") do
        if elementTable == nil then
            elementTable = {}
            for char in string.gmatch(line, "%a") do
                table.insert(elementTable, char)
            end
        elseif string.match(line, ".*->.*") then
            local chars = {}
            for char in string.gmatch(line, "%a") do
                table.insert(chars, char)
            end

            pairInsertion[chars[1]] = pairInsertion[chars[1]] or {}
            pairInsertion[chars[1]][chars[2]] = chars[3]
        end
    end
end

ReadInputData()

local function GetTableMaxMinDiff(t)
    local minEle, minNum, maxEle, maxNum
    for element, count in pairs(t) do
        if minNum == nil or minNum > count then
            minEle = element
            minNum = count
        end

        if maxNum == nil or maxNum < count then
            maxEle = element
            maxNum = count
        end
    end

    return maxNum - minNum
end

-- because this is only limit element pairs
-- and if we get one step pairs num
-- by using pairInsertion rules we can get next step pairs num
-- for example:
--     we get NN pair, if NN -> C
--     next step paris are: NC and CN pair
-- finally,by count pairs count we can get all element count!
local pairsNum = {}
for index = 1, #elementTable - 1 do
    pairsNum[elementTable[index]] = pairsNum[elementTable[index]] or {}
    pairsNum[elementTable[index]][elementTable[index + 1]] = (pairsNum[elementTable[index]][elementTable[index + 1]] or 0) + 1
end

for step = 1, 40 do
    local newPariNum = {}
    for ele1, eleTable in pairs(pairsNum) do
        for ele2, count in pairs(eleTable) do
            local newChar = pairInsertion[ele1][ele2]
            newPariNum[ele1] = newPariNum[ele1] or {}
            newPariNum[ele1][newChar] = (newPariNum[ele1][newChar] or 0) + count
            newPariNum[newChar] = newPariNum[newChar] or {}
            newPariNum[newChar][ele2] = (newPariNum[newChar][ele2] or 0) + count
        end
    end
    pairsNum = newPariNum
end

local elementCountTable = {}
for ele1, eleTable in pairs(pairsNum) do
    for ele2, count in pairs(eleTable) do
        elementCountTable[ele1] = (elementCountTable[ele1] or 0) + count
        elementCountTable[ele2] = (elementCountTable[ele2] or 0) + count
    end
end
-- the first and the last element count once and the rest of all count twice!
elementCountTable[elementTable[1]] = (elementCountTable[elementTable[1]] or 0) + 1
elementCountTable[elementTable[#elementTable]] = (elementCountTable[elementTable[#elementTable]] or 0) + 1
for index, _ in pairs(elementCountTable) do
    elementCountTable[index] = elementCountTable[index] / 2
end
print("result: " .. GetTableMaxMinDiff(elementCountTable))