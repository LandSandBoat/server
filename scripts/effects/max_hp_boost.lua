-----------------------------------
-- xi.effect.MAX_HP_BOOST
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.HPP, effect:getPower())   -- % HP bonus to max HP
    effect:addMod(xi.mod.HP, effect:getSubPower()) -- Flat HP bonus to max HP
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
