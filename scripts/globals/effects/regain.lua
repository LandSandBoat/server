-----------------------------------
-- xi.effect.REGAIN
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGAIN, effect:getPower() * 10)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGAIN, effect:getPower() * 10)
end

return effectObject
