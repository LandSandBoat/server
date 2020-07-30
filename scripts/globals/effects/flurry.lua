-----------------------------------
--
--  Flurry
--
-----------------------------------
require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SNAP_SHOT, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SNAP_SHOT, effect:getPower())
end
