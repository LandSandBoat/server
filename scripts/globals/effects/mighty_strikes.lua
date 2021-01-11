-----------------------------------
-- tpz.effect.MIGHTY_STRIKES
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
target:addMod(tpz.mod.CRITHITRATE, 100)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
target:addMod(tpz.mod.CRITHITRATE, -100)
end

return effect_object
