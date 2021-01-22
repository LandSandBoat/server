-----------------------------------
-- tpz.effect.DRACHEN_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addPetMod(tpz.mod.ACC, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delPetMod(tpz.mod.ACC, effect:getPower())
end

return effect_object
