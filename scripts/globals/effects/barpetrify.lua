-----------------------------------
--
-- tpz.effect.BARPETRIFY
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.PETRIFYRES, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.PETRIFYRES, effect:getPower())
end
