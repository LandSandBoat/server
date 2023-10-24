-----------------------------------
-- ID: 6258
-- Item: piece_of_shiromochi
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP + 20 VIT + 3 (Pet & Master)
-- Accuracy/Ranged Accuracy +14% (cap 70 on master, cap 108 on pet)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6258)
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
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.FOOD_ACCP, 14)
    target:delMod(xi.mod.FOOD_ACC_CAP, 70)
    target:delMod(xi.mod.FOOD_RACCP, 14)
    target:delMod(xi.mod.FOOD_RACC_CAP, 70)
    target:delPetMod(xi.mod.HP, 20)
    target:delPetMod(xi.mod.VIT, 3)
    target:delPetMod(xi.mod.FOOD_ACCP, 14)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 108)
    target:delPetMod(xi.mod.FOOD_RACCP, 14)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 108)
end

return itemObject
