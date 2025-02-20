-----------------------------------
-- xi.effect.VELOCITY_SHOT
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.VELOCITY_SHOT_EFFECT)

    effect:addMod(xi.mod.RATT, jpValue * 2)
    effect:addMod(xi.mod.ATTP, -15)
    effect:addMod(xi.mod.HASTE_ABILITY, -1500)
    effect:addMod(xi.mod.RATTP, 15)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
