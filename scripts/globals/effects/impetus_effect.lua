-----------------------------------
--
--     tpz.effect.IMPETUS_EFFECT
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.ATT, 100)
target:addMod(tpz.mod.CRITHITRATE, 50)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:addMod(tpz.mod.ATT, -100)
target:addMod(tpz.mod.CRITHITRATE, -50)
end