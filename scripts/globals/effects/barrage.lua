-----------------------------------
-- xi.effect.BARRAGE
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.BARRAGE_EFFECT)

    target:addMod(xi.mod.RATT, jpValue * 3)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.BARRAGE_EFFECT)

    target:delMod(xi.mod.RATT, jpValue * 3)
end

return effect_object
