-----------------------------------
-- ID: 6341
-- Item: bean_daifuku
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +20
-- VIT +3
-- Accuracy +10% (cap 50)
-- Ranged Accuracy +10% (cap 50)
-- Pet:
-- HP +20
-- VIT +3
-- Accuracy +10% (cap 75)
-- Ranged Accuracy +10% (cap 75)
-- Haste +3%
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6341)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 50)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 50)
    target:addPetMod(xi.mod.HP, 20)
    target:addPetMod(xi.mod.VIT, 3)
    target:addPetMod(xi.mod.FOOD_ACCP, 10)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 75)
    target:addPetMod(xi.mod.FOOD_RACCP, 10)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 75)
    target:addPetMod(xi.mod.HASTE_GEAR, 300)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 50)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 50)
    target:delPetMod(xi.mod.HP, 20)
    target:delPetMod(xi.mod.VIT, 3)
    target:delPetMod(xi.mod.FOOD_ACCP, 10)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 75)
    target:delPetMod(xi.mod.FOOD_RACCP, 10)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 75)
    target:delPetMod(xi.mod.HASTE_GEAR, 300)
end

return itemObject
