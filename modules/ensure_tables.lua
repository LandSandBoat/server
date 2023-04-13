-----------------------------------
-- Ensure Tables for Overrides
-- Iterate through all the sections of a table-string, and instantiate them if they don't exist
-----------------------------------

-----------------------------------

-- Ensure all NMs have files or create if not
function ensureTable(str)
    local parts = utils.splitStr(str, '.')
    local table = _G;

    for _, part in ipairs(parts) do
        table[part] = table[part] or {}
        table       = table[part]
    end

    -- printf(string.format("File %s doesn't exist. Creating virtual entry in cache table.", str))
end