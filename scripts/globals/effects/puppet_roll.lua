-----------------------------------
-- xi.effect.PUPPET_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addPetMod(xi.mod.MATT, effect:getPower())
    target:addPetMod(xi.mod.MACC, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delPetMod(xi.mod.MATT, effect:getPower())
    target:delPetMod(xi.mod.MACC, effect:getPower())
end

return effect_object
