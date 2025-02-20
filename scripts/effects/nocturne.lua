-----------------------------------
-- xi.effect.NOCTURNE
-----------------------------------
---@type TEffect
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    local power = effect:getPower()

    effect:addMod(xi.mod.FASTCAST, -power)
    effect:addMod(xi.mod.MACC, -power)
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
