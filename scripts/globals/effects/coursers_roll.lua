-----------------------------------
-- xi.effect.COURSERS_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- target:addMod(xi.mod.SNAPSHOT, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    -- target:delMod(xi.mod.SNAPSHOT, effect:getPower())
end

return effectObject
