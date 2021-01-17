-----------------------------------------
-- ID: 6344
-- Item: grape_daifuku+1
-- Food Effect: 60 Min, All Races
-----------------------------------------
-- HP + 30 (Pet & Master)
-- Vitality + 4 (Pet & Master)
-- Master MAB + 4 , Pet MAB + 15
-- Accuracy/Ranged Accuracy +11% (cap 54 on master, cap 81 on pet)
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6344)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.MATT, 4)
    target:addMod(tpz.mod.FOOD_ACCP, 11)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 54)
    target:addMod(tpz.mod.FOOD_RACCP, 11)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 54)
    target:addPetMod(tpz.mod.HP, 30)
    target:addPetMod(tpz.mod.VIT, 4)
    target:addPetMod(tpz.mod.MATT, 15)
    target:addPetMod(tpz.mod.FOOD_ACCP, 11)
    target:addPetMod(tpz.mod.FOOD_ACC_CAP, 81)
    target:addPetMod(tpz.mod.FOOD_RACCP, 11)
    target:addPetMod(tpz.mod.FOOD_RACC_CAP, 81)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.MATT, 4)
    target:delMod(tpz.mod.FOOD_ACCP, 11)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 54)
    target:delMod(tpz.mod.FOOD_RACCP, 11)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 54)
    target:delPetMod(tpz.mod.HP, 30)
    target:delPetMod(tpz.mod.VIT, 4)
    target:delPetMod(tpz.mod.MATT, 15)
    target:delPetMod(tpz.mod.FOOD_ACCP, 11)
    target:delPetMod(tpz.mod.FOOD_ACC_CAP, 81)
    target:delPetMod(tpz.mod.FOOD_RACCP, 11)
    target:delPetMod(tpz.mod.FOOD_RACC_CAP, 81)
end

return item_object
