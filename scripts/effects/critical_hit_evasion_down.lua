-----------------------------------
-- xi.effect.CRIT_HIT_EVASION_DOWN
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.CRITICAL_HIT_EVASION, -effect:getPower()) -- Lowers target crtical hit evasion, effectively raising oponents critical hit rate.
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
