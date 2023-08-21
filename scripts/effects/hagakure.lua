-----------------------------------
-- xi.effect.HAGAKURE
-----------------------------------
require("scripts/globals/jobpoints")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.HAGAKURE_EFFECT)

    target:addMod(xi.mod.SAVETP, 400)
    target:addMod(xi.mod.TP_BONUS, 1000 + (jpValue * 10))
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.HAGAKURE_EFFECT)

    target:delMod(xi.mod.SAVETP, 400)
    target:delMod(xi.mod.TP_BONUS, 1000 + (jpValue * 10))
end

return effectObject
