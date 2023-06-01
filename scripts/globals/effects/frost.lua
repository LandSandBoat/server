-----------------------------------
-- xi.effect.FROST
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local statReduction = (effect:getPower() - 1) * 2 + 5 -- Caster merits are included already.

    target:addMod(xi.mod.REGEN_DOWN, effect:getPower())
    target:addMod(xi.mod.AGI, -statReduction)

    target:delStatusEffect(xi.effect.CHOKE)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local statReduction = (effect:getPower() - 1) * 2 + 5 -- Caster merits are included already.

    target:delMod(xi.mod.REGEN_DOWN, effect:getPower())
    target:delMod(xi.mod.AGI, -statReduction)
end

return effectObject
