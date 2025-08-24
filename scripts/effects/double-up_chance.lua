-----------------------------------
-- xi.effect.DOUBLE_UP_CHANCE
-- Notes: Effect's subType stores abilityID. See: scripts/globals/job_utils/corsair.lua
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
