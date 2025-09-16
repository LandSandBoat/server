---@meta

-- luacheck: ignore 241
---@class CStub : CSpy
local CStub = {}

---Set a return value for the stub
---@param value any Value to return when stub is called
---@return nil
function CStub:returnValue(value)
end

---Set a side effect function for the stub
---@param func function Function to execute when stub is called
---@return nil
function CStub:sideEffect(func)
end
