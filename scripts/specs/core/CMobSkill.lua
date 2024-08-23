---@meta

-- luacheck: ignore 241
---@class CMobSkill
local CMobSkill = {}

---@nodiscard
---@return number
function CMobSkill:getTP()
end

---@nodiscard
---@return integer
function CMobSkill:getMobHPP()
end

---@nodiscard
---@return integer
function CMobSkill:getID()
end

---@nodiscard
---@return integer
function CMobSkill:getParam()
end

---@nodiscard
---@return boolean
function CMobSkill:isAoE()
end

---@nodiscard
---@return boolean
function CMobSkill:isConal()
end

---@nodiscard
---@return boolean
function CMobSkill:isSingle()
end

---@nodiscard
---@return boolean
function CMobSkill:hasMissMsg()
end

---@param message integer
---@return nil
function CMobSkill:setMsg(message)
end

---@nodiscard
---@return integer
function CMobSkill:getMsg()
end

---@nodiscard
---@return table
function CMobSkill:getTargets()
end

---@nodiscard
---@return integer
function CMobSkill:getTotalTargets()
end

---@nodiscard
---@return integer
function CMobSkill:getPrimaryTargetID()
end
