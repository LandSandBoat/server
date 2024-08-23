---@meta

-- luacheck: ignore 241
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

---@nodiscard
---@return boolean
function CSpell:canTargetEnemy()
end

---@nodiscard
---@return boolean
function CSpell:isAoE()
end

---@nodiscard
---@return boolean
function CSpell:tookEffect()
end

---@nodiscard
---@return integer
function CSpell:getTotalTargets()
end

---@nodiscard
---@return integer
function CSpell:getMagicBurstMessage()
end

---@nodiscard
---@return integer
function CSpell:getElement()
end

---@nodiscard
---@return integer
function CSpell:getID()
end

---@nodiscard
---@return integer
function CSpell:getMPCost()
end

---@nodiscard
---@return integer
function CSpell:getSkillType()
end

---@nodiscard
---@return integer
function CSpell:getSpellGroup()
end

---@nodiscard
---@return integer
function CSpell:getSpellFamily()
end

---@nodiscard
---@return integer
function CSpell:getFlag()
end

---@nodiscard
---@return integer
function CSpell:getCastTime()
end

---@nodiscard
---@return integer
function CSpell:getPrimaryTargetID()
end
