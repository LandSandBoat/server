-----------------------------------
--
--     tpz.effect.CASCADE
--     Grants a damage bonus to the next elemental magic spell cast based on TP consumed.
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.MATT, 100)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.MATT)
end