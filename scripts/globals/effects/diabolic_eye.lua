-----------------------------------
-- tpz.effect.DIABOLIC_EYE
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ACC, 15 + effect:getPower())
    target:addMod(tpz.mod.HPP, -15)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ACC, 15 + effect:getPower())
    target:delMod(tpz.mod.HPP, -15)
end

return effect_object
