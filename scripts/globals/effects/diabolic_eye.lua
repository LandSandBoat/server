-----------------------------------
--
-- tpz.effect.BERSERK
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

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
