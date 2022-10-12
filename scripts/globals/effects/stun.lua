-----------------------------------
-- xi.effect.STUN
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    if target:hasStatusEffect(xi.effect.CHARM_I) or target:hasStatusEffect(xi.effect.CHARM_II) then
        target:resetAI()
    end
end

return effect_object
