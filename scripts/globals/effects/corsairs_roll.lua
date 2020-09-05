-----------------------------------
--
--
--
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addMod(tpz.mod.EXP_BONUS, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.EXP_BONUS, effect:getPower())
end
