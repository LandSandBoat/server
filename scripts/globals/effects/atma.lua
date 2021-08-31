-----------------------------------
-- xi.effect.ATMA
-----------------------------------
require("scripts/globals/atma")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    xi.atma.onEffectGain(target, effect)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    xi.atma.onEffectLose(target, effect)
end

return effect_object
