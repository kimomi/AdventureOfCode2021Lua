local marchTable =
{
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['<'] = '>',
}

local scoreTable =
{
    [')'] = 3,
    [']'] = 57,
    ['}'] = 1197,
    ['>'] = 25137, 
}

local function match(chara, charb)
    return chara and charb and (marchTable[chara] == charb or marchTable[charb] == chara)
end

local scoreTable2 =
{
    ['('] = 1,
    ['['] = 2,
    ['{'] = 3,
    ['<'] = 4, 
}

local function getScore(t)
    local score = 0
    for i = #t, 1, -1 do
        score = score * 5
        score = score + scoreTable2[t[i]]
    end

    return score
end


local part1result = 0
local part2Table = {}
for line in io.lines("data") do
    local stack = {}
    local incomplete = true
    for c in string.gmatch(line, ".") do
        if stack[1] and match(c, stack[#stack]) then
            stack[#stack] = nil
        else
            if not marchTable[c] then
                part1result = part1result + scoreTable[c]
                incomplete = false
                break
            end
            table.insert(stack, c)
        end
    end

    if incomplete then
        table.insert(part2Table, getScore(stack))
    end
end


table.sort(part2Table, function (a, b)
    return a < b;
end)

print("part1result: " .. part1result)
print("part2result: " .. part2Table[(#part2Table + 1) / 2])
