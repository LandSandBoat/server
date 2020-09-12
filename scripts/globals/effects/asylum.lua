-----------------------------------
--
--     tpz.effect.ASYLUM
--
-----------------------------------

function onEffectGain(target, effect)
target:addMod(tpz.mod.SLEEPRES, 98)
target:addMod(tpz.mod.POISONRES, 98)
target:addMod(tpz.mod.PARALYZERES, 98)
target:addMod(tpz.mod.BLINDRES, 98)
target:addMod(tpz.mod.SILENCERES, 98)
target:addMod(tpz.mod.VIRUSRES, 98)
target:addMod(tpz.mod.PETRIFYRES, 98)
target:addMod(tpz.mod.BINDRES, 98)
target:addMod(tpz.mod.CURSERES, 98)
target:addMod(tpz.mod.GRAVITYRES, 98)
target:addMod(tpz.mod.SLOWRES, 98)
target:addMod(tpz.mod.STUNRES, 98)
target:addMod(tpz.mod.CHARMRES, 98)
target:addMod(tpz.mod.AMNESIARES, 98)
target:addMod(tpz.mod.LULLABYRES, 98)
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
target:delMod(tpz.mod.SLEEPRES, 98)
target:delMod(tpz.mod.POISONRES, 98)
target:delMod(tpz.mod.PARALYZERES, 98)
target:delMod(tpz.mod.BLINDRES, 98)
target:delMod(tpz.mod.SILENCERES, 98)
target:delMod(tpz.mod.VIRUSRES, 98)
target:delMod(tpz.mod.PETRIFYRES, 98)
target:delMod(tpz.mod.BINDRES, 98)
target:delMod(tpz.mod.CURSERES, 98)
target:delMod(tpz.mod.GRAVITYRES, 98)
target:delMod(tpz.mod.SLOWRES, 98)
target:delMod(tpz.mod.STUNRES, 98)
target:delMod(tpz.mod.CHARMRES, 98)
target:delMod(tpz.mod.AMNESIARES, 98)
target:delMod(tpz.mod.LULLABYRES, 98)
end