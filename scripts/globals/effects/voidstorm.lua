-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.DEX, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.VIT, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.AGI, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.INT, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.MND, math.floor(effect:getPower()/2))
    target:addMod(tpz.mod.CHR, math.floor(effect:getPower()/2))
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.DEX, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.VIT, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.AGI, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.INT, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.MND, math.floor(effect:getPower()/2))
    target:delMod(tpz.mod.CHR, math.floor(effect:getPower()/2))
end
