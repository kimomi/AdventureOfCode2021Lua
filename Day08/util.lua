table.contains = function(t, value)
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end

    return false
end

table.empty = function(t)
    for i, v in pairs(t) do
        return false
    end

    return true
end

table.tostring = function(value, name, prestr, up_table_list)
    up_table_list = up_table_list or {}
    prestr = prestr or ""
    name = name or 'table'

    if type(value) == "table" then
        if table.empty(value) then
            return string.format("%s%s = {}(empty table)\n", prestr, tostring(name))
        end

        if up_table_list[tostring(value)] then
            return string.format("%s%s=%s(table)\n", prestr, tostring(name), up_table_list[tostring(value)])
        end
        up_table_list[tostring(value)] = tostring(name)

        local result = string.format("%s%s = { ... }(table)\n", prestr, tostring(name))
        for k, v in pairs(value) do
            local kname = tostring(k)
            if type(v) ~= "function" then
                result = result .. table.tostring(v, kname, prestr .. "|   ", up_table_list)
            end
        end
        return result
    else
        return string.format("%s%s = %s(%s)\n", prestr, tostring(name), tostring(value), type(value))
    end
end
