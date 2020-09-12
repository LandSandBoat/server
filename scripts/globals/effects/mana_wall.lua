-----------------------------------
--
--     tpz.effect.MANA_WALL
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.DMG, 50)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.DMG, 50)
end