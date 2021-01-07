-----------------------------------
-- tpz.effect.ENLIGHTENMENT
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, effect:getPower())
    target:addMod(tpz.mod.MND, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, effect:getPower())
    target:delMod(tpz.mod.MND, effect:getPower())
end

return effect_object
