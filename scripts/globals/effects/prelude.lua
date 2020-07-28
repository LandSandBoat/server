-----------------------------------
--
--    tpz.effect.PRELUDE
-- getPower returns the TIER (e.g. 1, 2, 3, 4)
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.RACC, effect:getPower())
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.RACC, effect:getPower())
end
