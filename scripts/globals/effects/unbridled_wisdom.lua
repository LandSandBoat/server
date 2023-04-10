-----------------------------------
-- xi.effect.UNBRIDLED_WISDOM
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.UNBRIDLED_WISDOM_EFFECT)

    target:addMod(xi.mod.CONSERVE_MP, jpValue * 3)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.UNBRIDLED_WISDOM_EFFECT)

    target:delMod(xi.mod.CONSERVE_MP, jpValue * 3)
end

return effectObject
