-----------------------------------
--
-- tpz.effect.ABYSSEA_VIT
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, effect:getPower())
end
