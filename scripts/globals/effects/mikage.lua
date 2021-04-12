-----------------------------------
-- xi.effect.MIKAGE
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.MIKAGE_EFFECT)

    target:addMod(xi.mod.ATT, 3 * jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.MIKAGE_EFFECT)

    target:delMod(xi.mod.ATT, 3 * jpValue)
end

return effect_object
