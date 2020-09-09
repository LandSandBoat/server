-----------------------------------------
-- ID: 6539
-- Item: Altanas Repast +1
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- AoE:
-- STR+15
-- DEX+15
-- VIT+15
-- AGI+15
-- INT+15
-- MND+15
-- CHR+15
-- Accuracy+80
-- Attack+80
-- R. Accuracy+80
-- R. Attack+80
-- M. Accuracy+80
-- "M. Atk. Bonus"+15
-- "M. Def. Bonus"+4
-- Evasion+80
-- DEF+80
-- M. Evasion+80
-- "Store TP"+7
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
            member:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 6539)
        end
    end)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 15)
    target:addMod(tpz.mod.DEX, 15)
    target:addMod(tpz.mod.VIT, 15)
    target:addMod(tpz.mod.AGI, 15)
    target:addMod(tpz.mod.INT, 15)
    target:addMod(tpz.mod.MND, 15)
    target:addMod(tpz.mod.CHR, 15)
    target:addMod(tpz.mod.ACC, 80)
    target:addMod(tpz.mod.ATT, 80)
    target:addMod(tpz.mod.RACC, 80)
    target:addMod(tpz.mod.RATT, 80)
    target:addMod(tpz.mod.MACC, 80)
    target:addMod(tpz.mod.MATT, 15)
    target:addMod(tpz.mod.MDEF, 4)
    target:addMod(tpz.mod.EVA, 80)
    target:addMod(tpz.mod.DEF, 80)
    target:addMod(tpz.mod.MEVA, 80)
    target:addMod(tpz.mod.STORETP, 7)
    target:addPetMod(tpz.mod.STR, 15)
    target:addPetMod(tpz.mod.DEX, 15)
    target:addPetMod(tpz.mod.VIT, 15)
    target:addPetMod(tpz.mod.AGI, 15)
    target:addPetMod(tpz.mod.INT, 15)
    target:addPetMod(tpz.mod.MND, 15)
    target:addPetMod(tpz.mod.CHR, 15)
    target:addPetMod(tpz.mod.ACC, 80)
    target:addPetMod(tpz.mod.ATT, 80)
    target:addPetMod(tpz.mod.RACC, 80)
    target:addPetMod(tpz.mod.RATT, 80)
    target:addPetMod(tpz.mod.MACC, 80)
    target:addPetMod(tpz.mod.MATT, 15)
    target:addPetMod(tpz.mod.MDEF, 4)
    target:addPetMod(tpz.mod.EVA, 80)
    target:addPetMod(tpz.mod.DEF, 80)
    target:addPetMod(tpz.mod.MEVA, 80)
    target:addPetMod(tpz.mod.STORETP, 7)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 15)
    target:delMod(tpz.mod.DEX, 15)
    target:delMod(tpz.mod.VIT, 15)
    target:delMod(tpz.mod.AGI, 15)
    target:delMod(tpz.mod.INT, 15)
    target:delMod(tpz.mod.MND, 15)
    target:delMod(tpz.mod.CHR, 15)
    target:delMod(tpz.mod.ACC, 80)
    target:delMod(tpz.mod.ATT, 80)
    target:delMod(tpz.mod.RACC, 80)
    target:delMod(tpz.mod.RATT, 80)
    target:delMod(tpz.mod.MACC, 80)
    target:delMod(tpz.mod.MATT, 15)
    target:delMod(tpz.mod.MDEF, 4)
    target:delMod(tpz.mod.EVA, 80)
    target:delMod(tpz.mod.DEF, 80)
    target:delMod(tpz.mod.MEVA, 80)
    target:delMod(tpz.mod.STORETP, 7)
    target:delPetMod(tpz.mod.STR, 15)
    target:delPetMod(tpz.mod.DEX, 15)
    target:delPetMod(tpz.mod.VIT, 15)
    target:delPetMod(tpz.mod.AGI, 15)
    target:delPetMod(tpz.mod.INT, 15)
    target:delPetMod(tpz.mod.MND, 15)
    target:delPetMod(tpz.mod.CHR, 15)
    target:delPetMod(tpz.mod.ACC, 80)
    target:delPetMod(tpz.mod.ATT, 80)
    target:delPetMod(tpz.mod.RACC, 80)
    target:delPetMod(tpz.mod.RATT, 80)
    target:delPetMod(tpz.mod.MACC, 80)
    target:delPetMod(tpz.mod.MATT, 15)
    target:delPetMod(tpz.mod.MDEF, 4)
    target:delPetMod(tpz.mod.EVA, 80)
    target:delPetMod(tpz.mod.DEF, 80)
    target:delPetMod(tpz.mod.MEVA, 80)
    target:delPetMod(tpz.mod.STORETP, 7)
end
