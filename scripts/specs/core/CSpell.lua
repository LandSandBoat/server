---@meta

---@class CSpell
local CSpell = {}

---@param messageID integer
---@return nil
function CSpell:setMsg(messageID)
end

---@param modifier integer
---@return nil
function CSpell:setModifier(modifier)
end

---@param aoe integer
---@return nil
function CSpell:setAoE(aoe)
end

---@param flags integer
---@return nil
function CSpell:setFlag(flags)
end

---@param radius number
---@return nil
function CSpell:setRadius(radius)
end

---@param animationID integer
---@return nil
function CSpell:setAnimation(animationID)
end

---@param casttime integer
---@return nil
function CSpell:setCastTime(casttime)
end

---@param mpcost integer
---@return nil
function CSpell:setMPCost(mpcost)
end

---@return boolean
function CSpell:canTargetEnemy()
end

---@return boolean
function CSpell:isAoE()
end

---@return boolean
function CSpell:tookEffect()
end

---@return integer
function CSpell:getTotalTargets()
end

---@return integer
function CSpell:getMagicBurstMessage()
end

---@return integer
function CSpell:getElement()
end

---@return integer
function CSpell:getID()
end

---@return integer
function CSpell:getMPCost()
end

---@return integer
function CSpell:getSkillType()
end

---@return integer
function CSpell:getSpellGroup()
end

---@return integer
function CSpell:getSpellFamily()
end

---@return integer
function CSpell:getFlag()
end

---@return integer
function CSpell:getCastTime()
end

---@return integer
function CSpell:getPrimaryTargetID()
end
