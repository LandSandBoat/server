-----------------------------------
-- xi.effect.UNBRIDLED_WISDOM
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.UNBRIDLED_WISDOM_EFFECT)

    target:addMod(xi.mod.CONSERVE_MP, jpValue * 3)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.UNBRIDLED_WISDOM_EFFECT)

    target:delMod(xi.mod.CONSERVE_MP, jpValue * 3)
end

return effect_object
