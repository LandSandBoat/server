-----------------------------------------
-- ID: 6340
-- Item: rolanberry_daifuku_+1
-- Food Effect: 60 Min, All Races
-----------------------------------------
-- HP +30
-- VIT +4
-- Accuracy +11% (cap 54)
-- Ranged Accuracy +11% (cap 54)
-- Magic Accuracy +4
-- Pet:
-- HP +30
-- VIT +4
-- Accuracy +11% (cap 81)
-- Ranged Accuracy +11% (cap 81)
-- Magic Accuracy +15
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
    target:addStatusEffect(tpz.effect.FOOD,0,0,3600,6340)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.FOOD_ACCP, 11)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 54)
    target:addMod(tpz.mod.FOOD_RACCP, 11)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 54)
    target:addMod(tpz.mod.MACC, 4)
    target:addPetMod(tpz.mod.HP, 30)
    target:addPetMod(tpz.mod.VIT, 4)
    target:addPetMod(tpz.mod.FOOD_ACCP, 11)
    target:addPetMod(tpz.mod.FOOD_ACC_CAP, 81)
    target:addPetMod(tpz.mod.FOOD_RACCP, 11)
    target:addPetMod(tpz.mod.FOOD_RACC_CAP, 81)
    target:addPetMod(tpz.mod.MACC, 15)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.FOOD_ACCP, 11)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 54)
    target:delMod(tpz.mod.FOOD_RACCP, 11)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 54)
    target:delMod(tpz.mod.MACC, 4)
    target:delPetMod(tpz.mod.HP, 30)
    target:delPetMod(tpz.mod.VIT, 4)
    target:delPetMod(tpz.mod.FOOD_ACCP, 11)
    target:delPetMod(tpz.mod.FOOD_ACC_CAP, 81)
    target:delPetMod(tpz.mod.FOOD_RACCP, 11)
    target:delPetMod(tpz.mod.FOOD_RACC_CAP, 81)
    target:delPetMod(tpz.mod.MACC, 15)
end
