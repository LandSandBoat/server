-----------------------------------
-- xi.effect.COMPOSURE
-- Increases accuracy and lengthens recast time. Enhancement effects gained through white
-- and black magic you cast on yourself last longer.
-----------------------------------
require("scripts/globals/jobpoints")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.COMPOSURE_EFFECT)

    target:addMod(xi.mod.ACC, 15 + jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.COMPOSURE_EFFECT)

    target:delMod(xi.mod.ACC, 15 + jpValue)
end

return effectObject
