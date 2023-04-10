-----------------------------------
-- xi.effect.DARK_ARTS
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
    if target:getObjType() ~= xi.objType.TRUST then -- account for trusts
        target:recalculateAbilitiesTable()
    end

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

    if target:getObjType() ~= xi.objType.TRUST then
        target:recalculateSkillsTable()
    else -- account for trusts
        local rankD = target:getSkillLevel(xi.skill.ENFEEBLING_MAGIC)
        local artsRank = target:getMaxSkillLevel(target:getMainLvl(), xi.job.RDM, xi.skill.ENHANCING_MAGIC)
        local trustArts = artsRank - rankD

        -- TODO: update charutils to work with Trusts
        target:addMod(xi.mod.MACC, trustArts)
        -- cheats in MACC since Skill MODs aren't processed outside of charutils
    end
end

effectObject.onEffectTick = function(target, effect)
end

effectObject.onEffectLose = function(target, effect)
    if target:getObjType() ~= xi.objType.TRUST then -- account for trusts
        target:recalculateAbilitiesTable()
    end

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

    if target:getObjType() ~= xi.objType.TRUST then -- account for trusts
        target:recalculateSkillsTable()
    else
        local rankD = target:getSkillLevel(xi.skill.ENFEEBLING_MAGIC)
        local artsRank = target:getMaxSkillLevel(target:getMainLvl(), xi.job.RDM, xi.skill.ENHANCING_MAGIC)
        local trustArts = artsRank - rankD

        -- TODO: update charutils to work with Trusts
        target:delMod(xi.mod.MACC, trustArts)
        -- cheats out MACC since Skill MODs aren't processed outside of charutils
    end
end

return effectObject
