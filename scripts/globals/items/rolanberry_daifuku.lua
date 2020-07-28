-----------------------------------------
-- ID: 6339
-- Item: rolanberry_daifuku
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- HP +20
-- DEX +2
-- VIT +3
-- Accuracy +10% (cap 80)
-- Ranged Accuracy +10% (cap 80)
-- Magic Accuracy +50
-- Pet:
-- HP +20
-- DEX +2
-- VIT +3
-- Accuracy +10% (cap 105)
-- Ranged Accuracy +10% (cap 105)
-- Magic Accuracy +75
-- https://www.bg-wiki.com/bg/Rolan._Daifuku
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6339)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.FOOD_ACCP, 10)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 80)
    target:addMod(tpz.mod.FOOD_RACCP, 10)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 80)
    target:addMod(tpz.mod.MACC, 50)
    target:addPetMod(tpz.mod.HP, 20)
    target:addPetMod(tpz.mod.DEX, 2)
    target:addPetMod(tpz.mod.VIT, 3)
    target:addPetMod(tpz.mod.FOOD_ACCP, 10)
    target:addPetMod(tpz.mod.FOOD_ACC_CAP, 105)
    target:addPetMod(tpz.mod.FOOD_RACCP, 10)
    target:addPetMod(tpz.mod.FOOD_RACC_CAP, 105)
    target:addPetMod(tpz.mod.MACC, 75)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.FOOD_ACCP, 10)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 80)
    target:delMod(tpz.mod.FOOD_RACCP, 10)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 80)
    target:delMod(tpz.mod.MACC, 50)
    target:delPetMod(tpz.mod.HP, 20)
    target:delPetMod(tpz.mod.DEX, 2)
    target:delPetMod(tpz.mod.VIT, 3)
    target:delPetMod(tpz.mod.FOOD_ACCP, 10)
    target:delPetMod(tpz.mod.FOOD_ACC_CAP, 105)
    target:delPetMod(tpz.mod.FOOD_RACCP, 10)
    target:delPetMod(tpz.mod.FOOD_RACC_CAP, 105)
    target:delPetMod(tpz.mod.MACC, 75)
end
