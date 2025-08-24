-----------------------------------
-- xi.effect.ENCHANTMENT
-- Notes: Effect subType is used to store itemID of source item. See: CStatusEffectContainer::SetEffectParams
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
