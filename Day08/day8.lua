require("util")
local numMap = {}
local num2CharMap = 
{
    [0] = "abcefg",
    [1] = "cf",
    [2] = "acdeg",
    [3] = "acdfg",
    [4] = "bdcf",
    [5] = "abdfg",
    [6] = "abdefg",
    [7] = "acf",
    [8] = "abcdefg",
    [9] = "abcdfg",
}
local charNum = 
{
    a = 1,
    b = 2,
    c = 4,
    d = 8,
    e = 16,
    f = 32,
    g = 64,
}
local function generateNummap()
    for num, str in pairs(num2CharMap) do
        local strNum = 0
        for c in string.gmatch(str, "%a") do
            strNum = strNum + charNum[c]
        end
        numMap[strNum] = num
    end
end

generateNummap()

local function getDifferentChar(stra, strb)
    for c in string.gmatch(stra, "%a") do
        if not string.find(strb, c) then
            return c
        end
    end 
end

local function getCharNumTable(strTable)
    local result = {}
    local str7, str1, str4, str8
    local _5charStr = {}
    for i, str in ipairs(strTable) do
        local lenStr = string.len(str)
        if lenStr == 2 then
            str1 = str
        elseif lenStr == 3 then
            str7 = str
        elseif lenStr == 4 then
            str4 = str
        elseif lenStr == 7 then
            str8 = str
        elseif lenStr == 5 then
            table.insert(_5charStr, str)
        end
    end
    
    -- a
    result[getDifferentChar(str7, str1)] = charNum.a
    
    -- from 2 3 5 get different cbef 4 contains bdcf so we get e, then we get cbf
    local cbef = {}
    for c in string.gmatch(_5charStr[1], "%a") do
        if not string.find(_5charStr[2], c) or not string.find(_5charStr[3], c) then
            cbef[c] = (cbef[c] or 0) + 1
        end
    end 
    for c in string.gmatch(_5charStr[2], "%a") do
        if not string.find(_5charStr[1], c) or not string.find(_5charStr[3], c) then
            cbef[c] = (cbef[c] or 0) + 1
        end
    end 
    for c in string.gmatch(_5charStr[3], "%a") do
        if not string.find(_5charStr[1], c) or not string.find(_5charStr[2], c) then
            cbef[c] = (cbef[c] or 0) + 1
        end
    end 

    local chare, charb
    for char, v in pairs(cbef) do
        if not string.find(str4, char) then
            result[char] = charNum.e
            chare = char
        elseif v == 1 then
            result[char] = charNum.b
            charb = char
        end
    end

    for i, str in pairs(_5charStr) do
        if string.find(str, chare) then
            for c in pairs(cbef) do
                if c ~= chare then
                    if string.find(str, c) then
                        result[c] = charNum.c
                    end
                end
            end
        end

        if string.find(str, charb) then
            for c in pairs(cbef) do
                if c ~= charb then
                    if string.find(str, c) then
                        result[c] = charNum.f
                    end
                end
            end
        end
    end


    for c in string.gmatch(str4, "%a") do
        if not cbef[c] then
            result[c] = charNum.d
            break
        end
    end

    for c in string.gmatch(str8, "%a") do
        if not result[c] then
            result[c] = charNum.g
            break
        end
    end

    return result
end

local part1Result = 0
local part2Result = 0
for line in io.lines("data") do
    -- part 2 
    local strTable = {}
    for numChar in string.gmatch(string.match(line, "(.+) |"), "%a+") do
        table.insert(strTable, numChar)
    end
    local charNumTable = getCharNumTable(strTable)

    -- part 1 / part 2
    local tempNum = 0
    for numChar in string.gmatch(string.match(line, "| (.+)"), "%a+") do
        local lenChar = string.len(numChar)
        if lenChar == 2 or lenChar == 4 or lenChar == 3 or lenChar == 7 then
            part1Result = part1Result + 1
        end

        local n = 0
        for c in string.gmatch(numChar, "%a") do
            n = n + charNumTable[c]
        end
        tempNum = tempNum * 10 + numMap[n] 
    end
    part2Result = part2Result + tempNum
end

print("part1Result:" .. part1Result)
print("part2Result:" .. part2Result)
