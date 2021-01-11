-----------------------------------
-- tpz.effect.SPONTANEITY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.UFASTCAST, 150)
    effect:setFlag(tpz.effectFlag.MAGIC_BEGIN)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.UFASTCAST, 150)
end

return effect_object
