-----------------------------------
--
--      tpz.effect.CAROL
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.magic.resistMod[effect:getSubPower()], effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.magic.resistMod[effect:getSubPower()], effect:getPower())
end
