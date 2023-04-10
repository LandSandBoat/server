-----------------------------------
-- xi.effect.IFRITS_FAVOR
-----------------------------------
require("scripts/globals/status")
---------------------------------------------

local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
end

return effectObject
