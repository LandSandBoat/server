-----------------------------------------
-- ID: 6343
-- Item: grape_daifuku
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- HP + 20 (Pet & Master)
-- Vitality + 3 (Pet & Master)
-- Master MAB + 3 , Pet MAB + 14
-- Accuracy/Ranged Accuracy +10% (cap 50 on master, cap 75 on pet)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6343)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.MATT, 3)
    target:addMod(tpz.mod.FOOD_ACCP, 10)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 50)
    target:addMod(tpz.mod.FOOD_RACCP, 10)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 50)
    target:addPetMod(tpz.mod.HP, 20)
    target:addPetMod(tpz.mod.VIT, 3)
    target:addPetMod(tpz.mod.MATT, 14)
    target:addPetMod(tpz.mod.FOOD_ACCP, 10)
    target:addPetMod(tpz.mod.FOOD_ACC_CAP, 75)
    target:addPetMod(tpz.mod.FOOD_RACCP, 10)
    target:addPetMod(tpz.mod.FOOD_RACC_CAP, 75)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.MATT, 3)
    target:delMod(tpz.mod.FOOD_ACCP, 10)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 50)
    target:delMod(tpz.mod.FOOD_RACCP, 10)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 50)
    target:delPetMod(tpz.mod.HP, 20)
    target:delPetMod(tpz.mod.VIT, 3)
    target:delPetMod(tpz.mod.MATT, 14)
    target:delPetMod(tpz.mod.FOOD_ACCP, 10)
    target:delPetMod(tpz.mod.FOOD_ACC_CAP, 75)
    target:delPetMod(tpz.mod.FOOD_RACCP, 10)
    target:delPetMod(tpz.mod.FOOD_RACC_CAP, 75)
end
