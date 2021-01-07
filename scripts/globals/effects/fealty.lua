-----------------------------------
-- tpz.effect.FEALTY
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
   target:addMod(tpz.mod.MEVA, 200)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
   target:delMod(tpz.mod.MEVA, 200)
end

return effect_object
