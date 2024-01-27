-----------------------------------
-- ID: 6341
-- Item: bean_daifuku
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +20
-- VIT +5
-- Accuracy +10% (cap 80)
-- Ranged Accuracy +10% (cap 80)
-- Pet:
-- HP +20
-- VIT +5
-- Accuracy +10% (cap 105)
-- Ranged Accuracy +10% (cap 105)
-- Defense +10% (cap 100)
-- Haste +3%
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6341)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.VIT, 5)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 80)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 80)
    target:addPetMod(xi.mod.HP, 20)
    target:addPetMod(xi.mod.VIT, 5)
    target:addPetMod(xi.mod.FOOD_ACCP, 10)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 105)
    target:addPetMod(xi.mod.FOOD_RACCP, 10)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 105)
    target:addPetMod(xi.mod.FOOD_DEFP, 10)
    target:addPetMod(xi.mod.FOOD_DEF_CAP, 100)
    target:addPetMod(xi.mod.HASTE_GEAR, 300)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.VIT, 5)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 80)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 80)
    target:delPetMod(xi.mod.HP, 20)
    target:delPetMod(xi.mod.VIT, 5)
    target:delPetMod(xi.mod.FOOD_ACCP, 10)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 105)
    target:delPetMod(xi.mod.FOOD_RACCP, 10)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 105)
    target:delPetMod(xi.mod.FOOD_DEFP, 10)
    target:delPetMod(xi.mod.FOOD_DEF_CAP, 100)
    target:delPetMod(xi.mod.HASTE_GEAR, 300)
end

return itemObject
