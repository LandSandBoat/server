-----------------------------------
-- xi.effect.MANAWELL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.NO_SPELL_MP_DEPLETION, 100)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.NO_SPELL_MP_DEPLETION, 100)
end

return effectObject
