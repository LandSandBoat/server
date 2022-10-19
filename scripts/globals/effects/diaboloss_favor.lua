-----------------------------------
-- xi.effect.DIABOLOSS_FAVOR
-----------------------------------
require("scripts/globals/status")
-----------------------------------

local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REFRESH, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REFRESH, effect:getPower())
end

return effectObject
