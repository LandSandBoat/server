-----------------------------------
-- tpz.effect.CONFRONTATION
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target,effect)
    if target:getPet() then
        target:getPet():addStatusEffect(effect)
    end
end

effect_object.onEffectTick = function(target, effect)
end

function onEffectLose(target,effect)
    if target:getPet() then
        target:getPet():delStatusEffect(tpz.effect.CONFRONTATION)
    end
end

return effect_object
