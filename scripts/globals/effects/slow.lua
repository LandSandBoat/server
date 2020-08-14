-----------------------------------
--
--     tpz.effect.SLOW
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HASTE_MAGIC, -effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HASTE_MAGIC, -effect:getPower())
end
