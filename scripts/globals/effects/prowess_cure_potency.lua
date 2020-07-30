-----------------------------------
--
-- tpz.effect.PROWESS : Enhanced "Cure" potency
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.CURE_POTENCY, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.CURE_POTENCY, effect:getPower())
end
