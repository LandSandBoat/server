-----------------------------------
-- tpz.effect.PUPPET_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addPetMod(tpz.mod.MATT, effect:getPower())
    target:addPetMod(tpz.mod.MACC, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delPetMod(tpz.mod.MATT, effect:getPower())
    target:delPetMod(tpz.mod.MACC, effect:getPower())
end

return effect_object
