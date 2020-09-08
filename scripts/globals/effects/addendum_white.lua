-----------------------------------
--
--
--
-----------------------------------

function onEffectGain(target, effect)
    target:recalculateAbilitiesTable()
    local bonus = effect:getPower()
    local regen = effect:getSubPower()

    target:addMod(tpz.mod.WHITE_MAGIC_COST, -bonus)
    target:addMod(tpz.mod.WHITE_MAGIC_CAST, -bonus)
    target:addMod(tpz.mod.WHITE_MAGIC_RECAST, -bonus)

    if not (target:hasStatusEffect(tpz.effect.TABULA_RASA)) then
        target:addMod(tpz.mod.WHITE_MAGIC_COST, -10)
        target:addMod(tpz.mod.WHITE_MAGIC_CAST, -10)
        target:addMod(tpz.mod.WHITE_MAGIC_RECAST, -10)
        target:addMod(tpz.mod.BLACK_MAGIC_COST, 20)
        target:addMod(tpz.mod.BLACK_MAGIC_CAST, 20)
        target:addMod(tpz.mod.BLACK_MAGIC_RECAST, 20)
        target:addMod(tpz.mod.LIGHT_ARTS_REGEN, regen)
        target:addMod(tpz.mod.REGEN_DURATION, regen*2)
    end
    target:recalculateSkillsTable()
end

function onEffectTick(target, effect)
end

function onEffectLose(target, effect)
    target:recalculateAbilitiesTable()
    local bonus = effect:getPower()
    local regen = effect:getSubPower()

    target:delMod(tpz.mod.WHITE_MAGIC_COST, -bonus)
    target:delMod(tpz.mod.WHITE_MAGIC_CAST, -bonus)
    target:delMod(tpz.mod.WHITE_MAGIC_RECAST, -bonus)

    if not (target:hasStatusEffect(tpz.effect.TABULA_RASA)) then
        target:delMod(tpz.mod.WHITE_MAGIC_COST, -10)
        target:delMod(tpz.mod.WHITE_MAGIC_CAST, -10)
        target:delMod(tpz.mod.WHITE_MAGIC_RECAST, -10)
        target:delMod(tpz.mod.BLACK_MAGIC_COST, 20)
        target:delMod(tpz.mod.BLACK_MAGIC_CAST, 20)
        target:delMod(tpz.mod.BLACK_MAGIC_RECAST, 20)
        target:delMod(tpz.mod.LIGHT_ARTS_REGEN, regen)
        target:delMod(tpz.mod.REGEN_DURATION, regen*2)
    end
    target:recalculateSkillsTable()
end
