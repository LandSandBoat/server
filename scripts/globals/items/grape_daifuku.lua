-----------------------------------
-- ID: 6343
-- Item: grape_daifuku
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP + 20 (Pet & Master)
-- Vitality + 3 (Pet & Master)
-- Master MAB + 3 , Pet MAB + 14
-- Accuracy/Ranged Accuracy +10% (cap 50 on master, cap 75 on pet)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6343)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.MATT, 3)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 50)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 50)
    target:addPetMod(xi.mod.HP, 20)
    target:addPetMod(xi.mod.VIT, 3)
    target:addPetMod(xi.mod.MATT, 14)
    target:addPetMod(xi.mod.FOOD_ACCP, 10)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 75)
    target:addPetMod(xi.mod.FOOD_RACCP, 10)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 75)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.MATT, 3)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 50)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 50)
    target:delPetMod(xi.mod.HP, 20)
    target:delPetMod(xi.mod.VIT, 3)
    target:delPetMod(xi.mod.MATT, 14)
    target:delPetMod(xi.mod.FOOD_ACCP, 10)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 75)
    target:delPetMod(xi.mod.FOOD_RACCP, 10)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 75)
end

return item_object
