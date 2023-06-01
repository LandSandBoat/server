-----------------------------------
-- xi.effect.DAMAGE_SPIKES
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    -- TODO: Is this non elemental damage? Physical? Fire?
    -- Why would SE use a separate status effects from blaze spikes if its fire though..
    target:addMod(xi.mod.SPIKES, 1)
    target:addMod(xi.mod.SPIKES_DMG, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SPIKES, 1)
    target:delMod(xi.mod.SPIKES_DMG, effect:getPower())
end

return effectObject
