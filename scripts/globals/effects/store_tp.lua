-----------------------------------
--
-- Store TP Plus
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STORETP, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STORETP, effect:getPower())
end
