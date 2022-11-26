-----------------------------------
-- ID: 6260
-- Item: akamochi
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP + 20 (Pet & Master)
-- Vitality + 3 (Pet & Master)
-- Acc + 10% Cap: 50 (Pet & Master) Pet Cap: 75
-- R. Acc + 10% Cap: 50 (Pet & Master) Pet Cap: 75
-- Attack + 16% Cap: 50 (Pet & Master) Pet Cap: 75
-- R. Attack + 16% Cap: 50 (Pet & Master) Pet Cap: 75
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6260)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 50)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 50)
    target:addMod(xi.mod.FOOD_ATTP, 16)
    target:addMod(xi.mod.FOOD_ATT_CAP, 50)
    target:addMod(xi.mod.FOOD_RATTP, 16)
    target:addMod(xi.mod.FOOD_RATT_CAP, 50)
    target:addPetMod(xi.mod.HP, 20)
    target:addPetMod(xi.mod.VIT, 3)
    target:addPetMod(xi.mod.FOOD_ACCP, 10)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 75)
    target:addPetMod(xi.mod.FOOD_RACCP, 10)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 75)
    target:addPetMod(xi.mod.FOOD_ATTP, 16)
    target:addPetMod(xi.mod.FOOD_ATT_CAP, 75)
    target:addPetMod(xi.mod.FOOD_RATTP, 16)
    target:addPetMod(xi.mod.FOOD_RATT_CAP, 75)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 50)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 50)
    target:delMod(xi.mod.FOOD_ATTP, 16)
    target:delMod(xi.mod.FOOD_ATT_CAP, 50)
    target:delMod(xi.mod.FOOD_RATTP, 16)
    target:delMod(xi.mod.FOOD_RATT_CAP, 50)
    target:delPetMod(xi.mod.HP, 20)
    target:delPetMod(xi.mod.VIT, 3)
    target:delPetMod(xi.mod.FOOD_ACCP, 10)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 75)
    target:delPetMod(xi.mod.FOOD_RACCP, 10)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 75)
    target:delPetMod(xi.mod.FOOD_ATTP, 16)
    target:delPetMod(xi.mod.FOOD_ATT_CAP, 75)
    target:delPetMod(xi.mod.FOOD_RATTP, 16)
    target:delPetMod(xi.mod.FOOD_RATT_CAP, 75)
end

return itemObject
