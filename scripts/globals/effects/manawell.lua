-----------------------------------
-- xi.effect.MANAWELL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.NO_SPELL_MP_DEPLETION, 100)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.NO_SPELL_MP_DEPLETION, 100)
end

return effect_object
