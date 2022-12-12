-----------------------------------
-- xi.effect.SLUGGISH_DAZE_1
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local effectPower = effect:getPower()

    target:addMod(xi.mod.DEFP, -5 + (effectPower - 1) * -2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local effectPower = effect:getPower()

    target:delMod(xi.mod.DEFP, -5 + (effectPower - 1) * -2)
end

return effectObject
