-----------------------------------
-- Ensure Tables for Overrides
-- Iterate through all the sections of a table-string, and instantiate them if they don't exist
-----------------------------------

-----------------------------------

function ensureTable(str)
    local parts = utils.splitStr(str, '.')
    local table = _G;
    for _, part in ipairs(parts) do
        table[part] = table[part] or {}
        table = table[part]
    end
end