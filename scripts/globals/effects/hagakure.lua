-----------------------------------
--
--     tpz.effect.HAGAKURE
--
-----------------------------------

require("scripts/globals/status")

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SAVETP, 400)
    target:addMod(tpz.mod.TP_BONUS, 1000)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SAVETP, 400)
    target:delMod(tpz.mod.TP_BONUS, 1000)
end
