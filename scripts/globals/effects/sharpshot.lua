-----------------------------------
-- xi.effect.SHARPSHOT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SHARPSHOT_EFFECT)

    target:addMod(xi.mod.RACC, effect:getPower())
    target:addMod(xi.mod.RATT, jpValue * 2)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.SHARPSHOT_EFFECT)

    target:delMod(xi.mod.RACC, effect:getPower())
    target:delMod(xi.mod.RATT, jpValue * 2)
end

return effect_object
