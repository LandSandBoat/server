-----------------------------------
-- xi.effect.PUPPET_ROLL
-- Notes: Effect's subType stores caster's ID. See: scripts/globals/job_utils/corsair.lua
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addPetMod(xi.mod.MATT, effect:getPower())
    target:addPetMod(xi.mod.MACC, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delPetMod(xi.mod.MATT, effect:getPower())
    target:delPetMod(xi.mod.MACC, effect:getPower())
    xi.job_utils.corsair.onRollEffectLose(target, effect)
end

return effectObject
