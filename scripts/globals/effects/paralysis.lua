-----------------------------------
-- xi.effect.PARALYSIS
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.PARALYZE, effect:getPower())

    -- Immunobreak reset.
    target:setMod(xi.mod.PARALYZE_IMMUNOBREAK, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.PARALYZE, effect:getPower())
end

return effectObject
