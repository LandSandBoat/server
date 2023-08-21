-----------------------------------
-- xi.effect.CHAINSPELL
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CHAINSPELL_EFFECT)

    target:addMod(xi.mod.UFASTCAST, 150)
    target:addMod(xi.mod.MAGIC_DAMAGE, jpValue * 2)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    local jpValue = target:getJobPointLevel(xi.jp.CHAINSPELL_EFFECT)

    target:delMod(xi.mod.UFASTCAST, 150)
    target:delMod(xi.mod.MAGIC_DAMAGE, jpValue * 2)
end

return effectObject
