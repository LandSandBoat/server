-----------------------------------
-- xi.effect.ELEMENTAL_SEAL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MACC, 256)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MACC, 256)
end

return effectObject
