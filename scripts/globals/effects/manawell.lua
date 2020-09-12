-----------------------------------
--
--     tpz.effect.MANAWELL
--     Eliminates the cost of the next magic spell the target casts.
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.NO_SPELL_MP_DEPLETION, 100)
end

function onUseSpell(target, effect)
player:delMod(tpz.mod.PHANTOM_ROLL, 100)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.NO_SPELL_MP_DEPLETION, 100)
end