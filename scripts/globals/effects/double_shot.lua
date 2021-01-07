-----------------------------------
-- tpz.effect.DOUBLE_SHOT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DOUBLE_SHOT_RATE, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DOUBLE_SHOT_RATE, effect:getPower())
end

return effect_object
