---@meta

---@class CMobSkill
local CMobSkill = {}

---@return number
function CMobSkill:getTP()
end

---@return integer
function CMobSkill:getMobHPP()
end

---@return integer
function CMobSkill:getID()
end

---@return integer
function CMobSkill:getParam()
end

---@return boolean
function CMobSkill:isAoE()
end

---@return boolean
function CMobSkill:isConal()
end

---@return boolean
function CMobSkill:isSingle()
end

---@return boolean
function CMobSkill:hasMissMsg()
end

---@param message integer
---@return nil
function CMobSkill:setMsg(message)
end

---@return integer
function CMobSkill:getMsg()
end

---@return table
function CMobSkill:getTargets()
end

---@return integer
function CMobSkill:getTotalTargets()
end

---@return integer
function CMobSkill:getPrimaryTargetID()
end
