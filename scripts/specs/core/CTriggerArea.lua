---@meta

-- luacheck: ignore 241
---@class CTriggerArea
local CTriggerArea = {}

---@nodiscard
---@return integer
function CTriggerArea:GetTriggerAreaID()
end

---@nodiscard
---@return integer
function CTriggerArea:GetCount()
end

---@param count integer
---@return integer
function CTriggerArea:AddCount(count)
end

---@param count integer
---@return integer
function CTriggerArea:DelCount(count)
end
