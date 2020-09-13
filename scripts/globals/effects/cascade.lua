-----------------------------------
--
--     tpz.effect.CASCADE
--
-----------------------------------
function onEffectGain(target, effect)
    target:addMod(tpz.mod.MATT, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MATT)
end
