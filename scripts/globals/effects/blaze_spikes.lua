-----------------------------------
-- xi.effect.BLAZE_SPIKES
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SPIKES, 1)
    target:addMod(xi.mod.SPIKES_DMG, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SPIKES, 1)
    target:delMod(xi.mod.SPIKES_DMG, effect:getPower())
end

return effect_object
