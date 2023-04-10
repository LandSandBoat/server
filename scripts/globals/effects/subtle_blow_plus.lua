-----------------------------------
-- xi.effect.SUBTLE_BLOW_PLUS
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SUBTLE_BLOW, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SUBTLE_BLOW, effect:getPower())
end

return effectObject
