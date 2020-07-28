-----------------------------------
--
-- tpz.effect.BARVIRUS
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIRUSRES, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIRUSRES, effect:getPower())
end
