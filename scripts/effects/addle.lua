-----------------------------------
-- xi.effect.ADDLE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power    = effect:getPower()
    local subpower = math.floor(power / 2)
    effect:addMod(xi.mod.MACC, -power)
    effect:addMod(xi.mod.FASTCAST, -subpower)

    -- Immunobreak reset.
    target:setMod(xi.mod.ADDLE_IMMUNOBREAK, 0)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
