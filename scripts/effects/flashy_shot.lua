-----------------------------------
-- xi.effect.FLASHY_SHOT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local boost = target:getMerit(xi.merit.FLASHY_SHOT)

    effect:addMod(xi.mod.RATTP, boost)
    effect:addMod(xi.mod.ENMITY, 50)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
