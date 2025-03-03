-----------------------------------
-- xi.effect.BIND
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MOVE_SPEED_OVERRIDE, 300) -- Any number over 255 will make you stop

    -- Immunobreak reset.
    target:setMod(xi.mod.BIND_IMMUNOBREAK, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
