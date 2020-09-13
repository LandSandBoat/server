-----------------------------------
--
--      tpz.effect.BLOOD_RAGE
--
-----------------------------------
function onEffectGain(target, effect)
    target:addMod(tpz.mod.CRITHITRATE, 20)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:addMod(tpz.mod.CRITHITRATE, -20)
end
