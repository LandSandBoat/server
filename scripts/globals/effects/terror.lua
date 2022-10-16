-----------------------------------
-- xi.effect.TERROR
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if target:hasStatusEffect(xi.effect.CHARM_I) or target:hasStatusEffect(xi.effect.CHARM_II) then
        target:resetAI()
    end
end

return effectObject
