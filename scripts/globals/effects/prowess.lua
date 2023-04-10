-----------------------------------
-- xi.effect.PROWESS
-- From GoV
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.GOV_CLEARS, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.GOV_CLEARS, effect:getPower())
end

return effectObject
