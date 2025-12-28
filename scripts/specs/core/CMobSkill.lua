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
function CMobSkill:getMobHP()
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

---@param newAnimationSub integer
---@return nil
function CMobSkill:setFinalAnimationSub(newAnimationSub)
end

---@param newAnimationTime integer
---@return nil
function CMobSkill:setAnimationTime(newAnimationTime)
end

---@nodiscard
---@return xi.attackType
function CMobSkill:getAttackType()
end

---@param attackType xi.attackType
---@return nil
function CMobSkill:setAttackType(attackType)
end

---@nodiscard
---@return boolean
function CMobSkill:isCritical()
end

---@param isCritical boolean
---@return nil
function CMobSkill:setCritical(isCritical)
end

---@return xi.action.knockback
function CMobSkill:getKnockback()
end
