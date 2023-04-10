-----------------------------------
-- xi.effect.CORSAIRS_ROLL
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.EXP_BONUS, effect:getPower())
    target:addMod(xi.mod.CAPACITY_BONUS, effect:getPower())
    -- TODO: Exemplar Points (Not Implemented)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.EXP_BONUS, effect:getPower())
    target:delMod(xi.mod.CAPACITY_BONUS, effect:getPower())
    -- TODO: Exemplar Points (Not Implemented)
end

return effectObject
