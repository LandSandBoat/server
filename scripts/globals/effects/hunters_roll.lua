-----------------------------------
--
--
--
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ACC, effect:getPower())
    target:addMod(tpz.mod.RACC, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ACC, effect:getPower())
    target:delMod(tpz.mod.RACC, effect:getPower())
end
