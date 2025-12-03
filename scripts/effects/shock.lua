-----------------------------------
-- xi.effect.SHOCK
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local statReduction = (effect:getPower() - 1) * 2 + 5 -- Caster merits are included already.

    effect:addMod(xi.mod.REGEN_DOWN, effect:getPower())
    effect:addMod(xi.mod.MND, -statReduction)

    target:delStatusEffect(xi.effect.DROWN)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
