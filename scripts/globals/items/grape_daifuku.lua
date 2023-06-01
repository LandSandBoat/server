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
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6343)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 80)
    target:addMod(xi.mod.FOOD_ATTP, 10)
    target:addMod(xi.mod.FOOD_ATT_CAP, 50)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 80)
    target:addMod(xi.mod.FOOD_RATTP, 10)
    target:addMod(xi.mod.FOOD_RATT_CAP, 50)
    target:addMod(xi.mod.MATT, 3)
    target:addPetMod(xi.mod.HP, 20)
    target:addPetMod(xi.mod.STR, 2)
    target:addPetMod(xi.mod.VIT, 3)
    target:addPetMod(xi.mod.FOOD_ACCP, 10)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 105)
    target:addPetMod(xi.mod.FOOD_ATTP, 10)
    target:addPetMod(xi.mod.FOOD_ATT_CAP, 75)
    target:addPetMod(xi.mod.FOOD_RACCP, 10)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 105)
    target:addPetMod(xi.mod.FOOD_RATTP, 10)
    target:addPetMod(xi.mod.FOOD_RATT_CAP, 75)
    target:addPetMod(xi.mod.MATT, 14)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 80)
    target:delMod(xi.mod.FOOD_ATTP, 10)
    target:delMod(xi.mod.FOOD_ATT_CAP, 50)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 80)
    target:delMod(xi.mod.FOOD_RATTP, 10)
    target:delMod(xi.mod.FOOD_RATT_CAP, 50)
    target:delMod(xi.mod.MATT, 3)
    target:delPetMod(xi.mod.HP, 20)
    target:delPetMod(xi.mod.STR, 2)
    target:delPetMod(xi.mod.VIT, 3)
    target:delPetMod(xi.mod.FOOD_ACCP, 10)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 105)
    target:delPetMod(xi.mod.FOOD_ATTP, 10)
    target:delPetMod(xi.mod.FOOD_ATT_CAP, 75)
    target:delPetMod(xi.mod.FOOD_RACCP, 10)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 105)
    target:delPetMod(xi.mod.FOOD_RATTP, 10)
    target:delPetMod(xi.mod.FOOD_RATT_CAP, 75)
    target:delPetMod(xi.mod.MATT, 14)
end

return itemObject
