-----------------------------------
--
--     tpz.effect.TRIPLE_SHOT
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.EXTRA_DMG_CHANCE, 19)
target:addMod(tpz.mod.OCC_DO_EXTRA_DMG, 300)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.EXTRA_DMG_CHANCE, 19)
target:delMod(tpz.mod.OCC_DO_EXTRA_DMG, 300)
end