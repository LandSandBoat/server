-----------------------------------
-- xi.effect.HAGAKURE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.HAGAKURE_EFFECT)

    effect:addMod(xi.mod.SAVETP, effect:getPower())
    effect:addMod(xi.mod.TP_BONUS, effect:getSubPower() + jpValue * 10)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
