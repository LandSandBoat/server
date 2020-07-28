-----------------------------------
--
--
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.TRIPLE_ATTACK, effect:getPower())
    target:addMod(tpz.mod.DOUBLE_ATTACK, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.TRIPLE_ATTACK, effect:getPower())
    target:delMod(tpz.mod.DOUBLE_ATTACK, 100)
end
