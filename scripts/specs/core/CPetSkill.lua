---@meta

-- luacheck: ignore 241
---@class CPetSkill
local CPetSkill = {}

---@nodiscard
---@return number
function CPetSkill:getTP()
end

---@nodiscard
---@return integer
function CPetSkill:getMobHPP()
end

---@nodiscard
---@return integer
function CPetSkill:getID()
end

---@nodiscard
---@return integer
function CPetSkill:getParam()
end

---@nodiscard
---@return boolean
function CPetSkill:isAoE()
end

---@nodiscard
---@return boolean
function CPetSkill:isConal()
end

---@nodiscard
---@return boolean
function CPetSkill:isSingle()
end

---@nodiscard
---@return boolean
function CPetSkill:hasMissMsg()
end

---@param message integer
---@return nil
function CPetSkill:setMsg(message)
end

---@nodiscard
---@return integer
function CPetSkill:getMsg()
end

---@nodiscard
---@return integer
function CPetSkill:getTotalTargets()
end

---@nodiscard
---@return integer
function CPetSkill:getPrimaryTargetID()
end
