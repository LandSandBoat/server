-----------------------------------
-- xi.effect.BOLTERS_ROLL
-- Notes: Effect's subType stores caster's ID. See: scripts/globals/job_utils/corsair.lua
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MOVE_SPEED_BOLTERS_ROLL, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    xi.job_utils.corsair.onRollEffectLose(target, effect)
end

return effectObject
