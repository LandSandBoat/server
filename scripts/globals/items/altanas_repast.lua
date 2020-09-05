-----------------------------------------
-- ID: 6538
-- Item: Altanas Repast
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- AoE:
-- STR+10
-- DEX+10
-- VIT+10
-- AGI+10
-- INT+10
-- MND+10
-- CHR+10
-- Accuracy+70
-- Attack+70
-- R. Accuracy+70
-- R. Attack+70
-- M. Accuracy+70
-- "M. Atk. Bonus"+10
-- "M. Def. Bonus"+3
-- Evasion+70
-- DEF+70
-- M. Evasion+70
-- "Store TP"+6
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:forMembersInRange(30, function(member)
        if not member:hasStatusEffect(tpz.effect.FOOD) and not member:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
            member:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 6538)
        end
    end)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 10)
    target:addMod(tpz.mod.DEX, 10)
    target:addMod(tpz.mod.VIT, 10)
    target:addMod(tpz.mod.AGI, 10)
    target:addMod(tpz.mod.INT, 10)
    target:addMod(tpz.mod.MND, 10)
    target:addMod(tpz.mod.CHR, 10)
    target:addMod(tpz.mod.ACC, 70)
    target:addMod(tpz.mod.ATT, 70)
    target:addMod(tpz.mod.RACC, 70)
    target:addMod(tpz.mod.RATT, 70)
    target:addMod(tpz.mod.MACC, 70)
    target:addMod(tpz.mod.MATT, 10)
    target:addMod(tpz.mod.MDEF, 3)
    target:addMod(tpz.mod.EVA, 70)
    target:addMod(tpz.mod.DEF, 70)
    target:addMod(tpz.mod.MEVA, 70)
    target:addMod(tpz.mod.STORETP, 6)
    target:addPetMod(tpz.mod.STR, 10)
    target:addPetMod(tpz.mod.DEX, 10)
    target:addPetMod(tpz.mod.VIT, 10)
    target:addPetMod(tpz.mod.AGI, 10)
    target:addPetMod(tpz.mod.INT, 10)
    target:addPetMod(tpz.mod.MND, 10)
    target:addPetMod(tpz.mod.CHR, 10)
    target:addPetMod(tpz.mod.ACC, 70)
    target:addPetMod(tpz.mod.ATT, 70)
    target:addPetMod(tpz.mod.RACC, 70)
    target:addPetMod(tpz.mod.RATT, 70)
    target:addPetMod(tpz.mod.MACC, 70)
    target:addPetMod(tpz.mod.MATT, 10)
    target:addPetMod(tpz.mod.MDEF, 3)
    target:addPetMod(tpz.mod.EVA, 70)
    target:addPetMod(tpz.mod.DEF, 70)
    target:addPetMod(tpz.mod.MEVA, 70)
    target:addPetMod(tpz.mod.STORETP, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 10)
    target:delMod(tpz.mod.DEX, 10)
    target:delMod(tpz.mod.VIT, 10)
    target:delMod(tpz.mod.AGI, 10)
    target:delMod(tpz.mod.INT, 10)
    target:delMod(tpz.mod.MND, 10)
    target:delMod(tpz.mod.CHR, 10)
    target:delMod(tpz.mod.ACC, 70)
    target:delMod(tpz.mod.ATT, 70)
    target:delMod(tpz.mod.RACC, 70)
    target:delMod(tpz.mod.RATT, 70)
    target:delMod(tpz.mod.MACC, 70)
    target:delMod(tpz.mod.MATT, 10)
    target:delMod(tpz.mod.MDEF, 3)
    target:delMod(tpz.mod.EVA, 70)
    target:delMod(tpz.mod.DEF, 70)
    target:delMod(tpz.mod.MEVA, 70)
    target:delMod(tpz.mod.STORETP, 6)
    target:delPetMod(tpz.mod.STR, 10)
    target:delPetMod(tpz.mod.DEX, 10)
    target:delPetMod(tpz.mod.VIT, 10)
    target:delPetMod(tpz.mod.AGI, 10)
    target:delPetMod(tpz.mod.INT, 10)
    target:delPetMod(tpz.mod.MND, 10)
    target:delPetMod(tpz.mod.CHR, 10)
    target:delPetMod(tpz.mod.ACC, 70)
    target:delPetMod(tpz.mod.ATT, 70)
    target:delPetMod(tpz.mod.RACC, 70)
    target:delPetMod(tpz.mod.RATT, 70)
    target:delPetMod(tpz.mod.MACC, 70)
    target:delPetMod(tpz.mod.MATT, 10)
    target:delPetMod(tpz.mod.MDEF, 3)
    target:delPetMod(tpz.mod.EVA, 70)
    target:delPetMod(tpz.mod.DEF, 70)
    target:delPetMod(tpz.mod.MEVA, 70)
    target:delPetMod(tpz.mod.STORETP, 6)
end
