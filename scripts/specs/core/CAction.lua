---@meta

-- luacheck: ignore 241
---@class CAction
local CAction = {}

---@param actionTargetId integer
---@param newActionTargetId integer
---@return nil
function CAction:ID(actionTargetId, newActionTargetId)
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
---@param actionTargetId integer
---@return integer
function CAction:getParam(actionTargetId)
end

---@param actionTargetId integer
---@param param integer
---@return nil
function CAction:param(actionTargetId, param)
end

---@param actionTargetId integer
---@param messageId integer
---@return nil
function CAction:messageID(actionTargetId, messageId)
end

---@nodiscard
---@param actionTargetId integer
---@return integer?
function CAction:getMsg(actionTargetId)
end

---@nodiscard
---@param actionTargetId integer
---@return integer?
function CAction:getAnimation(actionTargetId)
end

---@param actionTargetId integer
---@param animation integer
---@return nil
function CAction:setAnimation(actionTargetId, animation)
end

---@nodiscard
---@return xi.action.category
function CAction:getCategory()
end

---@param category xi.action.category
---@return nil
function CAction:setCategory(category)
end

---@param actionTargetId integer
---@param info xi.action.info
---@return nil
function CAction:info(actionTargetId, info)
end

---@param actionTargetId integer
---@param resolution xi.action.resolution
---@return nil
function CAction:resolution(actionTargetId, resolution)
end

---@param actionTargetId integer
---@param modifier xi.action.modifier
---@return nil
function CAction:modifier(actionTargetId, modifier)
end

---@param actionTargetId integer
---@param additionalEffect xi.action.addEffect
---@return nil
function CAction:additionalEffect(actionTargetId, additionalEffect)
end

---@param actionTargetId integer
---@param addEffectParam integer
---@return nil
function CAction:addEffectParam(actionTargetId, addEffectParam)
end

---@param actionTargetId integer
---@param addEffectMessage integer
---@return nil
function CAction:addEffectMessage(actionTargetId, addEffectMessage)
end

---@param actionTargetId integer
---@return boolean
function CAction:addAdditionalTarget(actionTargetId)
end

---@param actionTargetId integer
---@param hitDistortion xi.action.hitDistortion
---@return nil
function CAction:hitDistortion(actionTargetId, hitDistortion)
end

---@param actionTargetId integer
---@param knockback xi.action.knockback
---@return nil
function CAction:knockback(actionTargetId, knockback)
end

---@param target CBaseEntity
---@param atkType xi.attackType
---@param damage integer
---@param isCritical boolean?
---@return nil
function CAction:recordDamage(target, atkType, damage, isCritical)
end
