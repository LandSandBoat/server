-----------------------------------
-- xi.effect.GALLANTS_ROLL
-- Notes: Effect's subType stores caster's ID. See: scripts/globals/job_utils/corsair.lua
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DMG, -effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DMG, -effect:getPower())
    xi.job_utils.corsair.onRollEffectLose(target, effect)
end

return effectObject
