-----------------------------------
--
-- tpz.effect.SHELL
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
   target:addMod(tpz.mod.DMGMAGIC, -effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
   target:delMod(tpz.mod.DMGMAGIC, -effect:getPower())
end
