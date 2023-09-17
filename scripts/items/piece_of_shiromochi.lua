-----------------------------------
-- ID: 6343
-- Item: grape_daifuku
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP + 20 STR + 2 VIT + 3 (Pet & Master)
-- Accuracy/Ranged Accuracy +10% (cap 80 on master, cap 105 on pet)
-- Attack/Ranged Attack +11% (cap 50 on master, cap 75 on pet)
-- Master MAB + 3 , Pet MAB + 14
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6343)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FOOD_ACCP, 14)
    target:addMod(xi.mod.FOOD_ACC_CAP, 70)
    target:addMod(xi.mod.FOOD_RACCP, 14)
    target:addMod(xi.mod.FOOD_RACC_CAP, 70)
    target:addPetMod(xi.mod.HP, 20)
    target:addPetMod(xi.mod.VIT, 3)
    target:addPetMod(xi.mod.FOOD_ACCP, 14)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 108)
    target:addPetMod(xi.mod.FOOD_RACCP, 14)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 108)
end

itemObject.onEffectLose = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FOOD_ACCP, 14)
    target:addMod(xi.mod.FOOD_ACC_CAP, 70)
    target:addMod(xi.mod.FOOD_RACCP, 14)
    target:addMod(xi.mod.FOOD_RACC_CAP, 70)
    target:addPetMod(xi.mod.HP, 20)
    target:addPetMod(xi.mod.VIT, 3)
    target:addPetMod(xi.mod.FOOD_ACCP, 14)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 108)
    target:addPetMod(xi.mod.FOOD_RACCP, 14)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 108)
end

return itemObject
