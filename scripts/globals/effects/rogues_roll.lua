-----------------------------------
--
--
--
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addMod(tpz.mod.CRITHITRATE, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.CRITHITRATE, effect:getPower())
end
