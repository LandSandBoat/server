-----------------------------------------
-- ID: 6540
-- Item: Altanas Repast +2
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- AoE:
-- STR+20
-- DEX+20
-- VIT+20
-- AGI+20
-- INT+20
-- MND+20
-- CHR+20
-- Accuracy+90
-- Attack+90
-- R. Accuracy+90
-- R. Attack+90
-- M. Accuracy+90
-- "M. Atk. Bonus"+20
-- "M. Def. Bonus"+5
-- Evasion+90
-- DEF+90
-- M. Evasion+90
-- "Store TP"+8
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
            member:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 6540)
        end
    end)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 20)
    target:addMod(tpz.mod.DEX, 20)
    target:addMod(tpz.mod.VIT, 20)
    target:addMod(tpz.mod.AGI, 20)
    target:addMod(tpz.mod.INT, 20)
    target:addMod(tpz.mod.MND, 20)
    target:addMod(tpz.mod.CHR, 20)
    target:addMod(tpz.mod.ACC, 90)
    target:addMod(tpz.mod.ATT, 90)
    target:addMod(tpz.mod.RACC, 90)
    target:addMod(tpz.mod.RATT, 90)
    target:addMod(tpz.mod.MACC, 90)
    target:addMod(tpz.mod.MATT, 20)
    target:addMod(tpz.mod.MDEF, 5)
    target:addMod(tpz.mod.EVA, 90)
    target:addMod(tpz.mod.DEF, 90)
    target:addMod(tpz.mod.MEVA, 90)
    target:addMod(tpz.mod.STORETP, 8)
    target:addPetMod(tpz.mod.STR, 20)
    target:addPetMod(tpz.mod.DEX, 20)
    target:addPetMod(tpz.mod.VIT, 20)
    target:addPetMod(tpz.mod.AGI, 20)
    target:addPetMod(tpz.mod.INT, 20)
    target:addPetMod(tpz.mod.MND, 20)
    target:addPetMod(tpz.mod.CHR, 20)
    target:addPetMod(tpz.mod.ACC, 90)
    target:addPetMod(tpz.mod.ATT, 90)
    target:addPetMod(tpz.mod.RACC, 90)
    target:addPetMod(tpz.mod.RATT, 90)
    target:addPetMod(tpz.mod.MACC, 90)
    target:addPetMod(tpz.mod.MATT, 20)
    target:addPetMod(tpz.mod.MDEF, 5)
    target:addPetMod(tpz.mod.EVA, 90)
    target:addPetMod(tpz.mod.DEF, 90)
    target:addPetMod(tpz.mod.MEVA, 90)
    target:addPetMod(tpz.mod.STORETP, 8)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 20)
    target:delMod(tpz.mod.DEX, 20)
    target:delMod(tpz.mod.VIT, 20)
    target:delMod(tpz.mod.AGI, 20)
    target:delMod(tpz.mod.INT, 20)
    target:delMod(tpz.mod.MND, 20)
    target:delMod(tpz.mod.CHR, 20)
    target:delMod(tpz.mod.ACC, 90)
    target:delMod(tpz.mod.ATT, 90)
    target:delMod(tpz.mod.RACC, 90)
    target:delMod(tpz.mod.RATT, 90)
    target:delMod(tpz.mod.MACC, 90)
    target:delMod(tpz.mod.MATT, 20)
    target:delMod(tpz.mod.MDEF, 5)
    target:delMod(tpz.mod.EVA, 90)
    target:delMod(tpz.mod.DEF, 90)
    target:delMod(tpz.mod.MEVA, 90)
    target:delMod(tpz.mod.STORETP, 8)
    target:delPetMod(tpz.mod.STR, 20)
    target:delPetMod(tpz.mod.DEX, 20)
    target:delPetMod(tpz.mod.VIT, 20)
    target:delPetMod(tpz.mod.AGI, 20)
    target:delPetMod(tpz.mod.INT, 20)
    target:delPetMod(tpz.mod.MND, 20)
    target:delPetMod(tpz.mod.CHR, 20)
    target:delPetMod(tpz.mod.ACC, 90)
    target:delPetMod(tpz.mod.ATT, 90)
    target:delPetMod(tpz.mod.RACC, 90)
    target:delPetMod(tpz.mod.RATT, 90)
    target:delPetMod(tpz.mod.MACC, 90)
    target:delPetMod(tpz.mod.MATT, 20)
    target:delPetMod(tpz.mod.MDEF, 5)
    target:delPetMod(tpz.mod.EVA, 90)
    target:delPetMod(tpz.mod.DEF, 90)
    target:delPetMod(tpz.mod.MEVA, 90)
    target:delPetMod(tpz.mod.STORETP, 8)
end
