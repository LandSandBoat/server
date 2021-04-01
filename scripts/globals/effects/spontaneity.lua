-----------------------------------
-- xi.effect.SPONTANEITY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.UFASTCAST, 150)
    effect:setFlag(xi.effectFlag.MAGIC_BEGIN)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.UFASTCAST, 150)
end

return effect_object
