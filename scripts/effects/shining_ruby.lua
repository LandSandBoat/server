-----------------------------------
-- xi.effect.SHINING_RUBY
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEFP, effect:getPower())
    effect:addMod(xi.mod.DMGMAGIC, -effect:getSubPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
