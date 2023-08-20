-----------------------------------
-- xi.effect.SLOW
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HASTE_MAGIC, -effect:getPower())

    -- Immunobreak reset.
    target:setMod(xi.mod.SLOW_IMMUNOBREAK, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HASTE_MAGIC, -effect:getPower())
end

return effectObject
