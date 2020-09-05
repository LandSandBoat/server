-----------------------------------
--
-- tpz.effect.AGGRESSOR
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.RACC, effect:getPower())
    target:addMod(tpz.mod.ACC, 25)
    target:addMod(tpz.mod.EVA, -25)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.RACC, effect:getPower())
    target:delMod(tpz.mod.ACC, 25)
    target:delMod(tpz.mod.EVA, -25)
end
