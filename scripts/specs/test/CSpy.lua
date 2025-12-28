---@meta

-- luacheck: ignore 241
---@class CSpy
---@field calls table Array of call records, each containing 'args' and 'returned' fields
local CSpy = {}

---Assert that the spy was called (at least once if no argument, or exactly n times)
---@param times? integer Expected number of calls
---@return nil
function CSpy:called(times)
end

---Assert that the spy was called with the specified arguments
---@param ... any Expected arguments
---@return nil
function CSpy:calledWith(...)
end

---Clear all recorded calls
---@return nil
function CSpy:clear()
end
