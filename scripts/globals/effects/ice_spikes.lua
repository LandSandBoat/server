-----------------------------------
-- xi.effect.ICE_SPIKES
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SPIKES, 2)
    target:addMod(xi.mod.SPIKES_DMG, effect:getPower())
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SPIKES, 2)
    target:delMod(xi.mod.SPIKES_DMG, effect:getPower())
end

return effectObject
