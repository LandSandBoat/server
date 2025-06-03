-----------------------------------
-- xi.effect.BIND
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:setPower(target:getBaseSpeed())
    target:setBaseSpeed(0)

    -- Immunobreak reset.
    target:setMod(xi.mod.BIND_IMMUNOBREAK, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:setBaseSpeed(effect:getPower())
end

return effectObject
