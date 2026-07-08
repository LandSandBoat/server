-----------------------------------
-- xi.effect.MACRO_TEST
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- TODO:
    -- - Permanent 1000 TP - Cannot gain or lose
    -- - Outgoing damage is 0 against ANY target
end

effectObject.onEffectTick = function(target, effect)
    -- TODO: If too far from Macro Test (~5y), effect auto-cancels
end

effectObject.onEffectLose = function(target, effect)
    -- TP is reset to 0 on effect loss
    target:setTP(0)
end

return effectObject
