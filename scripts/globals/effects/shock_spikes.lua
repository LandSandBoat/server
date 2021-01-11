-----------------------------------
-- tpz.effect.SHOCK_SPIKES
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.SPIKES, 5)
    target:addMod(tpz.mod.SPIKES_DMG, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.SPIKES, 5)
    target:delMod(tpz.mod.SPIKES_DMG, effect:getPower())
end

return effect_object
