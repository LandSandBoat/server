-----------------------------------
-- tpz.effect.WEAKENED_DAZE_2
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MEVA, -15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MEVA, -15)
end

return effect_object
