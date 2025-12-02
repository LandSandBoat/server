-----------------------------------
-- xi.effect.ENCHANTMENT
-- Notes: Effect subType is used to store itemID of source item. See: CStatusEffectContainer::SetEffectParams
-- TODO: Most if not all enchantments are attached to an usable item.
-- Will need to audit any outliers not using sourceType/sourceTypeParam. subType is currently used as a fallback.
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
