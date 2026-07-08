-----------------------------------
-- xi.effect.ASSASSINS_CHARGE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.QUAD_ATTACK, effect:getPower())
    effect:addMod(xi.mod.TRIPLE_ATTACK, 100)
    effect:addMod(xi.mod.CRITHITRATE, effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
