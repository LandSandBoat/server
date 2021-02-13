-----------------------------------
-- tpz.effect.DARK_ARTS
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:recalculateAbilitiesTable()
    local bonus = effect:getPower()
    local helix = effect:getSubPower()

    target:addMod(tpz.mod.BLACK_MAGIC_COST, -bonus)
    target:addMod(tpz.mod.BLACK_MAGIC_CAST, -bonus)
    target:addMod(tpz.mod.BLACK_MAGIC_RECAST, -bonus)

    if not (target:hasStatusEffect(tpz.effect.TABULA_RASA)) then
        target:addMod(tpz.mod.BLACK_MAGIC_COST, -10)
        target:addMod(tpz.mod.BLACK_MAGIC_CAST, -10)
        target:addMod(tpz.mod.BLACK_MAGIC_RECAST, -10)
        target:addMod(tpz.mod.WHITE_MAGIC_COST, 20)
        target:addMod(tpz.mod.WHITE_MAGIC_CAST, 20)
        target:addMod(tpz.mod.WHITE_MAGIC_RECAST, 20)
        target:addMod(tpz.mod.HELIX_EFFECT, helix)
        target:addMod(tpz.mod.HELIX_DURATION, 72)
    end
    target:recalculateSkillsTable()
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:recalculateAbilitiesTable()
    local bonus = effect:getPower()
    local helix = effect:getSubPower()

    target:delMod(tpz.mod.BLACK_MAGIC_COST, -bonus)
    target:delMod(tpz.mod.BLACK_MAGIC_CAST, -bonus)
    target:delMod(tpz.mod.BLACK_MAGIC_RECAST, -bonus)

    if not (target:hasStatusEffect(tpz.effect.TABULA_RASA)) then
        target:delMod(tpz.mod.BLACK_MAGIC_COST, -10)
        target:delMod(tpz.mod.BLACK_MAGIC_CAST, -10)
        target:delMod(tpz.mod.BLACK_MAGIC_RECAST, -10)
        target:delMod(tpz.mod.WHITE_MAGIC_COST, 20)
        target:delMod(tpz.mod.WHITE_MAGIC_CAST, 20)
        target:delMod(tpz.mod.WHITE_MAGIC_RECAST, 20)
        target:delMod(tpz.mod.HELIX_EFFECT, helix)
        target:delMod(tpz.mod.HELIX_DURATION, 72)
    end
    target:recalculateSkillsTable()
end

return effect_object
