-----------------------------------
-- xi.effect.MIKAGE
-----------------------------------
require("scripts/globals/jobpoints")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.MIKAGE_EFFECT)

    target:addMod(xi.mod.ATT, 3 * jpValue)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.MIKAGE_EFFECT)

    target:delMod(xi.mod.ATT, 3 * jpValue)
end

return effectObject
