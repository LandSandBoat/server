-----------------------------------
-- xi.effect.DARK_ARTS
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:recalculateAbilitiesTable()
    local bonus = effect:getPower()
    local helix = effect:getSubPower()

    target:addMod(xi.mod.BLACK_MAGIC_COST, -bonus)
    target:addMod(xi.mod.BLACK_MAGIC_CAST, -bonus)
    target:addMod(xi.mod.BLACK_MAGIC_RECAST, -bonus)

    if not (target:hasStatusEffect(xi.effect.TABULA_RASA)) then
        target:addMod(xi.mod.BLACK_MAGIC_COST, -10)
        target:addMod(xi.mod.BLACK_MAGIC_CAST, -10)
        target:addMod(xi.mod.BLACK_MAGIC_RECAST, -10)
        target:addMod(xi.mod.WHITE_MAGIC_COST, 20)
        target:addMod(xi.mod.WHITE_MAGIC_CAST, 20)
        target:addMod(xi.mod.WHITE_MAGIC_RECAST, 20)
        target:addMod(xi.mod.HELIX_EFFECT, helix)
        target:addMod(xi.mod.HELIX_DURATION, 72)
    end
    target:recalculateSkillsTable()
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:recalculateAbilitiesTable()
    local bonus = effect:getPower()
    local helix = effect:getSubPower()

    target:delMod(xi.mod.BLACK_MAGIC_COST, -bonus)
    target:delMod(xi.mod.BLACK_MAGIC_CAST, -bonus)
    target:delMod(xi.mod.BLACK_MAGIC_RECAST, -bonus)

    if not (target:hasStatusEffect(xi.effect.TABULA_RASA)) then
        target:delMod(xi.mod.BLACK_MAGIC_COST, -10)
        target:delMod(xi.mod.BLACK_MAGIC_CAST, -10)
        target:delMod(xi.mod.BLACK_MAGIC_RECAST, -10)
        target:delMod(xi.mod.WHITE_MAGIC_COST, 20)
        target:delMod(xi.mod.WHITE_MAGIC_CAST, 20)
        target:delMod(xi.mod.WHITE_MAGIC_RECAST, 20)
        target:delMod(xi.mod.HELIX_EFFECT, helix)
        target:delMod(xi.mod.HELIX_DURATION, 72)
    end
    target:recalculateSkillsTable()
end

return effect_object
