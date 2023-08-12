-----------------------------------
-- xi.effect.CLARION_CALL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MAXIMUM_SONGS_BONUS, 1)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MAXIMUM_SONGS_BONUS, 1)
end

return effectObject
