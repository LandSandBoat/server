-----------------------------------
-- ID: 6344
-- Item: grape_daifuku+1
-- Food Effect: 60 Min, All Races
-----------------------------------
-- HP + 30 STR + 3 VIT + 4 (Pet & Master)
-- Accuracy/Ranged Accuracy +11% (cap 85 on master, cap 110 on pet)
-- Attack/Ranged Attack +11% (cap 55 on master, cap 80 on pet)
-- Master MAB + 4 , Pet MAB + 15
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6344)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.STR, 3)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 85)
    target:addMod(xi.mod.FOOD_ATTP, 11)
    target:addMod(xi.mod.FOOD_ATT_CAP, 55)
    target:addMod(xi.mod.FOOD_RACCP, 11)
    target:addMod(xi.mod.FOOD_RACC_CAP, 85)
    target:addMod(xi.mod.FOOD_RATTP, 11)
    target:addMod(xi.mod.FOOD_RATT_CAP, 55)
    target:addMod(xi.mod.MATT, 4)
    target:addPetMod(xi.mod.HP, 30)
    target:addPetMod(xi.mod.STR, 3)
    target:addPetMod(xi.mod.VIT, 4)
    target:addPetMod(xi.mod.FOOD_ACCP, 11)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 110)
    target:addPetMod(xi.mod.FOOD_ATTP, 11)
    target:addPetMod(xi.mod.FOOD_ATT_CAP, 80)
    target:addPetMod(xi.mod.FOOD_RACCP, 11)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 110)
    target:addPetMod(xi.mod.FOOD_RATTP, 11)
    target:addPetMod(xi.mod.FOOD_RATT_CAP, 80)
    target:addPetMod(xi.mod.MATT, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.STR, 3)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 85)
    target:delMod(xi.mod.FOOD_ATTP, 11)
    target:delMod(xi.mod.FOOD_ATT_CAP, 55)
    target:delMod(xi.mod.FOOD_RACCP, 11)
    target:delMod(xi.mod.FOOD_RACC_CAP, 85)
    target:delMod(xi.mod.FOOD_RATTP, 11)
    target:delMod(xi.mod.FOOD_RATT_CAP, 55)
    target:delMod(xi.mod.MATT, 4)
    target:delPetMod(xi.mod.HP, 30)
    target:delPetMod(xi.mod.STR, 3)
    target:delPetMod(xi.mod.VIT, 4)
    target:delPetMod(xi.mod.FOOD_ACCP, 11)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 110)
    target:delPetMod(xi.mod.FOOD_ATTP, 11)
    target:delPetMod(xi.mod.FOOD_ATT_CAP, 80)
    target:delPetMod(xi.mod.FOOD_RACCP, 11)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 110)
    target:delPetMod(xi.mod.FOOD_RATTP, 11)
    target:delPetMod(xi.mod.FOOD_RATT_CAP, 80)
    target:delPetMod(xi.mod.MATT, 15)
end

return itemObject
