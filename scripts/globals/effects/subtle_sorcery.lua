-----------------------------------
-- xi.effect.SUBTLE_SORCERY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MACC, 100)
end

effect_object.onEffectTick = function(target, effect)
    target:addMod(xi.mod.ENMITY, -20)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MACC, 100)
    target:delMod(xi.mod.ENMITY)
end

return effect_object
