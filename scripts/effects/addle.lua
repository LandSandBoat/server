-----------------------------------
-- xi.effect.ADDLE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FASTCAST, -effect:getPower()) -- Yes we are subtracting in addMod()
    effect:addMod(xi.mod.MACC, -effect:getSubPower()) -- This is intentional

    -- Immunobreak reset.
    target:setMod(xi.mod.ADDLE_IMMUNOBREAK, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
