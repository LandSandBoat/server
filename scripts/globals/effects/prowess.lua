-----------------------------------
--
-- tpz.effect.PROWESS
-- From GoV
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.GOV_CLEARS, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.GOV_CLEARS, effect:getPower())
end
