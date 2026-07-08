-----------------------------------
-- Kupofried's EXP Aura
-- EXP_BONUS: +20% static value
-- Stacks with other forms of dedication
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.EXP_BONUS, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
