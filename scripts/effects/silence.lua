-----------------------------------
-- xi.effect.SILENCE
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- Immunobreak reset.
    target:setMod(xi.mod.SILENCE_IMMUNOBREAK, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
