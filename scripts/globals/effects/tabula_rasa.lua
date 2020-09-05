-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    local regen = effect:getSubPower()
    local helix = effect:getPower()

    if (target:hasStatusEffect(tpz.effect.LIGHT_ARTS) or target:hasStatusEffect(tpz.effect.ADDENDUM_WHITE)) then
        target:addMod(tpz.mod.BLACK_MAGIC_COST, -30)
        target:addMod(tpz.mod.BLACK_MAGIC_CAST, -30)
        target:addMod(tpz.mod.BLACK_MAGIC_RECAST, -30)
        target:addMod(tpz.mod.LIGHT_ARTS_REGEN, math.ceil(regen/1.5))
        target:addMod(tpz.mod.REGEN_DURATION, math.ceil((regen*2)/1.5))
        target:addMod(tpz.mod.HELIX_EFFECT, helix)
        target:addMod(tpz.mod.HELIX_DURATION, 108)
    elseif (target:hasStatusEffect(tpz.effect.DARK_ARTS) or target:hasStatusEffect(tpz.effect.ADDENDUM_BLACK)) then
        target:addMod(tpz.mod.WHITE_MAGIC_COST, -30)
        target:addMod(tpz.mod.WHITE_MAGIC_CAST, -30)
        target:addMod(tpz.mod.WHITE_MAGIC_RECAST, -30)
        target:addMod(tpz.mod.LIGHT_ARTS_REGEN, regen)
        target:addMod(tpz.mod.REGEN_DURATION, regen*2)
        target:addMod(tpz.mod.HELIX_EFFECT, math.ceil(helix/1.5))
        target:addMod(tpz.mod.HELIX_DURATION, 36)
    else
        target:addMod(tpz.mod.BLACK_MAGIC_COST, -10)
        target:addMod(tpz.mod.BLACK_MAGIC_CAST, -10)
        target:addMod(tpz.mod.BLACK_MAGIC_RECAST, -10)
        target:addMod(tpz.mod.WHITE_MAGIC_COST, -10)
        target:addMod(tpz.mod.WHITE_MAGIC_CAST, -10)
        target:addMod(tpz.mod.WHITE_MAGIC_RECAST, -10)
        target:addMod(tpz.mod.LIGHT_ARTS_REGEN, regen)
        target:addMod(tpz.mod.REGEN_DURATION, regen*2)
        target:addMod(tpz.mod.HELIX_EFFECT, helix)
        target:addMod(tpz.mod.HELIX_DURATION, 108)
    end
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    local regen = effect:getSubPower()
    local helix = effect:getPower()

    if (target:hasStatusEffect(tpz.effect.LIGHT_ARTS) or target:hasStatusEffect(tpz.effect.ADDENDUM_WHITE)) then
        target:delMod(tpz.mod.BLACK_MAGIC_COST, -30)
        target:delMod(tpz.mod.BLACK_MAGIC_CAST, -30)
        target:delMod(tpz.mod.BLACK_MAGIC_RECAST, -30)
        target:delMod(tpz.mod.LIGHT_ARTS_REGEN, math.ceil(regen/1.5))
        target:delMod(tpz.mod.REGEN_DURATION, math.ceil((regen*2)/1.5))
        target:delMod(tpz.mod.HELIX_EFFECT, helix)
        target:delMod(tpz.mod.HELIX_DURATION, 108)
    elseif (target:hasStatusEffect(tpz.effect.DARK_ARTS) or target:hasStatusEffect(tpz.effect.ADDENDUM_BLACK)) then
        target:delMod(tpz.mod.WHITE_MAGIC_COST, -30)
        target:delMod(tpz.mod.WHITE_MAGIC_CAST, -30)
        target:delMod(tpz.mod.WHITE_MAGIC_RECAST, -30)
        target:delMod(tpz.mod.LIGHT_ARTS_REGEN, regen)
        target:delMod(tpz.mod.REGEN_DURATION, regen*2)
        target:delMod(tpz.mod.HELIX_EFFECT, math.ceil(helix/1.5))
        target:delMod(tpz.mod.HELIX_DURATION, 36)
    else
        target:delMod(tpz.mod.BLACK_MAGIC_COST, -10)
        target:delMod(tpz.mod.BLACK_MAGIC_CAST, -10)
        target:delMod(tpz.mod.BLACK_MAGIC_RECAST, -10)
        target:delMod(tpz.mod.WHITE_MAGIC_COST, -10)
        target:delMod(tpz.mod.WHITE_MAGIC_CAST, -10)
        target:delMod(tpz.mod.WHITE_MAGIC_RECAST, -10)
        target:delMod(tpz.mod.LIGHT_ARTS_REGEN, regen)
        target:delMod(tpz.mod.REGEN_DURATION, regen*2)
        target:delMod(tpz.mod.HELIX_EFFECT, helix)
        target:delMod(tpz.mod.HELIX_DURATION, 108)
    end
end
