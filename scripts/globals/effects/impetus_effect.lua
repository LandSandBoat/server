-----------------------------------
-- tpz.effect.IMPETUS_EFFECT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ATT, 100)
    target:addMod(tpz.mod.CRITHITRATE, 50)
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ATT, 100)
    target:delMod(tpz.mod.CRITHITRATE, 50)
end

return effect_object
