-----------------------------------
-- xi.effect.BEWILDERED_DAZE_2
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.CRITICAL_HIT_EVASION, -7) -- Lowers target crtical hit evasion, effectively raising oponents critical hit rate.
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
