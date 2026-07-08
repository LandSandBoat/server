-----------------------------------
-- xi.effect.CORSAIRS_ROLL
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.EXP_BONUS, effect:getPower())
    effect:addMod(xi.mod.CAPACITY_BONUS, effect:getPower())
    -- TODO: Exemplar Points (Not Implemented)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    -- TODO: Exemplar Points (Not Implemented)
    xi.job_utils.corsair.onRollEffectLose(target, effect)
end

return effectObject
