-----------------------------------
-- xi.effect.COMPOSURE
-- Increases accuracy and lengthens recast time. Enhancement effects gained through white
-- and black magic you cast on yourself last longer.
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.COMPOSURE_EFFECT)

    target:addMod(xi.mod.ACC, 15 + jpValue)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.COMPOSURE_EFFECT)

    target:delMod(xi.mod.ACC, 15 + jpValue)
end

return effect_object
