-----------------------------------
-- tpz.effect.SUBTLE_SORCERY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MACC, 100)
end

effect_object.onEffectTick = function(target, effect)
    target:addMod(tpz.mod.ENMITY, -20)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MACC, 100)
    target:delMod(tpz.mod.ENMITY)
end

return effect_object
