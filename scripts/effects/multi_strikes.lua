-----------------------------------
-- xi.effect.MULTI_STRIKES
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if effect:getTier() == 2 then
        target:addMod(xi.mod.TRIPLE_ATTACK, effect:getPower())
    else
        target:addMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if effect:getTier() == 2 then
        target:delMod(xi.mod.TRIPLE_ATTACK, effect:getPower())
    else
        target:delMod(xi.mod.DOUBLE_ATTACK, effect:getPower())
    end
end

return effectObject
