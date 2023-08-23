-----------------------------------
-- xi.effect.WEIGHT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MOVE, -effect:getPower())

    -- Immunobreak reset.
    target:setMod(xi.mod.GRAVITY_IMMUNOBREAK, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MOVE, -effect:getPower())
end

return effectObject
