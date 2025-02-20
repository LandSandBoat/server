---@meta

-- luacheck: ignore 241
---@class ITriggerArea
local ITriggerArea = {}

---@nodiscard
---@return integer
function ITriggerArea:getTriggerAreaID()
end

---@nodiscard
---@return integer
function ITriggerArea:getCount()
end

---@param count integer
---@return integer
function ITriggerArea:addCount(count)
end

---@param count integer
---@return integer
function ITriggerArea:delCount(count)
end
