-----------------------------------
-- tpz.effect.PROWESS
-- Enhanced "Cure" potency
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.CURE_POTENCY, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.CURE_POTENCY, effect:getPower())
end

return effect_object
