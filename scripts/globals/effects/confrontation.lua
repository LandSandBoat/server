-----------------------------------
-- xi.effect.CONFRONTATION
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    if target:getPet() then
        target:getPet():addStatusEffect(effect)
    end
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    if target:getPet() then
        target:getPet():delStatusEffect(xi.effect.CONFRONTATION)
    end
end

return effect_object
