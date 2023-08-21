-----------------------------------
-- xi.effect.ASTRAL_CONDUIT
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.BP_DELAY, 99)
    target:addMod(xi.mod.MPP, 100)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.BP_DELAY, 99)
    target:delMod(xi.mod.MPP, 100)
end

return effectObject
