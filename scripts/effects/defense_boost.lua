-----------------------------------
-- xi.effect.DEFENSE_BOOST
-- When a subpower is provided this buff acts as a 100% physical damage negation
-- While the attacker is in front within the angle of the subpower
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEFP, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEFP, effect:getPower())
end

return effectObject
