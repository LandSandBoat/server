-----------------------------------
--
--     tpz.effect.SENGIKORI
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.SKILLCHAINDMG, 100)
target:addMod(tpz.mod.UDMGMAGIC, 25)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.SKILLCHAINDMG, 100)
target:delMod(tpz.mod.UDMGMAGIC, 25)
end