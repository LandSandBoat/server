---@meta

-- luacheck: ignore 241
---@class CAttack
local CAttack = {}

---@nodiscard
---@return boolean
function CAttack:isCritical()
end

---@param critical boolean
---@return nil
function CAttack:setCritical(critical)
end
