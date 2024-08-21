---@meta

---@class CPetSkill
local CPetSkill = {}

---@return number
function CPetSkill:getTP()
end

---@return integer
function CPetSkill:getMobHPP()
end

---@return integer
function CPetSkill:getID()
end

---@return integer
function CPetSkill:getParam()
end

---@return boolean
function CPetSkill:isAoE()
end

---@return boolean
function CPetSkill:isConal()
end

---@return boolean
function CPetSkill:isSingle()
end

---@return boolean
function CPetSkill:hasMissMsg()
end

---@param message integer
---@return nil
function CPetSkill:setMsg(message)
end

---@return integer
function CPetSkill:getMsg()
end

---@return integer
function CPetSkill:getTotalTargets()
end

---@return integer
function CPetSkill:getPrimaryTargetID()
end
