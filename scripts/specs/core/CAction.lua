---@meta

-- luacheck: ignore 241
---@class CAction
local CAction = {}

---@param actionTargetID integer
---@param newActionTargetID integer
---@return nil
function CAction:ID(actionTargetID, newActionTargetID)
end

---@nodiscard
---@return integer
function CAction:getPrimaryTargetID()
end

---@param recast integer
---@return nil
function CAction:setRecast(recast)
end

---@nodiscard
---@return integer
function CAction:getRecast()
end

---@param actionid integer
---@return nil
function CAction:actionID(actionid)
end

---@nodiscard
---@param actionTargetID integer
---@return integer
function CAction:getParam(actionTargetID)
end

---@param actionTargetID integer
---@param param integer
---@return nil
function CAction:param(actionTargetID, param)
end

---@param actionTargetID integer
---@param messageID integer
---@return nil
function CAction:messageID(actionTargetID, messageID)
end

---@nodiscard
---@param actionTargetID integer
---@return integer?
function CAction:getMsg(actionTargetID)
end

---@nodiscard
---@param actionTargetID integer
---@return integer?
function CAction:getAnimation(actionTargetID)
end

---@param actionTargetID integer
---@param animation integer
---@return nil
function CAction:setAnimation(actionTargetID, animation)
end

---@nodiscard
---@return integer
function CAction:getCategory()
end

---@param category integer
---@return nil
function CAction:setCategory(category)
end

---@param actionTargetID integer
---@param speceffect integer
---@return nil
function CAction:speceffect(actionTargetID, speceffect)
end

---@param actionTargetID integer
---@param reaction integer
---@return nil
function CAction:reaction(actionTargetID, reaction)
end

---@param actionTargetID integer
---@param modifier integer
---@return nil
function CAction:modifier(actionTargetID, modifier)
end

---@param actionTargetID integer
---@param additionalEffect integer
---@return nil
function CAction:additionalEffect(actionTargetID, additionalEffect)
end

---@param actionTargetID integer
---@param addEffectParam integer
---@return nil
function CAction:addEffectParam(actionTargetID, addEffectParam)
end

---@param actionTargetID integer
---@param addEffectMessage integer
---@return nil
function CAction:addEffectMessage(actionTargetID, addEffectMessage)
end

---@param actionTargetID integer
---@return boolean
function CAction:addAdditionalTarget(actionTargetID)
end
