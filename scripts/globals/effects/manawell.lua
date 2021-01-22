-----------------------------------
-- tpz.effect.MANAWELL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.NO_SPELL_MP_DEPLETION, 100)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.NO_SPELL_MP_DEPLETION, 100)
end

return effect_object
