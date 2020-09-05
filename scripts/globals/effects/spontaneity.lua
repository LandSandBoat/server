-----------------------------------
--
--     tpz.effect.SPONTANEITY
--
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.UFASTCAST, 150)
    effect:setFlag(tpz.effectFlag.MAGIC_BEGIN)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.UFASTCAST, 150)
end
