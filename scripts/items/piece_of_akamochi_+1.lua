-----------------------------------
-- ID: 6261
-- Item: akamochi+1
-- Food Effect: 60 Min, All Races
-----------------------------------
-- HP + 30 (Pet & Master)
-- Vitality + 4 (Pet & Master)
-- Attack + 17% Cap: 54 (Pet & Master) Pet Cap: 81
-- Accuracy + 11% Cap: 54 (Pet & Master) Pet Cap: 81
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6261)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 54)
    target:addMod(xi.mod.FOOD_RACCP, 11)
    target:addMod(xi.mod.FOOD_RACC_CAP, 54)
    target:addMod(xi.mod.FOOD_ATTP, 17)
    target:addMod(xi.mod.FOOD_ATT_CAP, 54)
    target:addMod(xi.mod.FOOD_RATTP, 17)
    target:addMod(xi.mod.FOOD_RATT_CAP, 54)
    target:addPetMod(xi.mod.HP, 30)
    target:addPetMod(xi.mod.VIT, 4)
    target:addPetMod(xi.mod.FOOD_ACCP, 11)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 81)
    target:addPetMod(xi.mod.FOOD_RACCP, 11)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 81)
    target:addPetMod(xi.mod.FOOD_ATTP, 17)
    target:addPetMod(xi.mod.FOOD_ATT_CAP, 82)
    target:addPetMod(xi.mod.FOOD_RATTP, 17)
    target:addPetMod(xi.mod.FOOD_RATT_CAP, 82)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 54)
    target:delMod(xi.mod.FOOD_RACCP, 11)
    target:delMod(xi.mod.FOOD_RACC_CAP, 54)
    target:delMod(xi.mod.FOOD_ATTP, 17)
    target:delMod(xi.mod.FOOD_ATT_CAP, 54)
    target:delMod(xi.mod.FOOD_RATTP, 17)
    target:delMod(xi.mod.FOOD_RATT_CAP, 54)
    target:delPetMod(xi.mod.HP, 30)
    target:delPetMod(xi.mod.VIT, 4)
    target:delPetMod(xi.mod.FOOD_ACCP, 11)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 81)
    target:delPetMod(xi.mod.FOOD_RACCP, 11)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 81)
    target:delPetMod(xi.mod.FOOD_ATTP, 17)
    target:delPetMod(xi.mod.FOOD_ATT_CAP, 82)
    target:delPetMod(xi.mod.FOOD_RATTP, 17)
    target:delPetMod(xi.mod.FOOD_RATT_CAP, 82)
end

return itemObject
