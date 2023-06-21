-----------------------------------
-- ID: 6339
-- Item: rolanberry_daifuku
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +20
-- DEX +2
-- VIT +3
-- Accuracy +10% (cap 80)
-- Ranged Accuracy +10% (cap 80)
-- Magic Accuracy +50
-- Pet:
-- HP +20
-- DEX +2
-- VIT +3
-- Accuracy +10% (cap 105)
-- Ranged Accuracy +10% (cap 105)
-- Magic Accuracy +75
-- https://www.bg-wiki.com/bg/Rolan._Daifuku
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6339)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 80)
    target:addMod(xi.mod.FOOD_RACCP, 10)
    target:addMod(xi.mod.FOOD_RACC_CAP, 80)
    target:addMod(xi.mod.MACC, 50)
    target:addPetMod(xi.mod.HP, 20)
    target:addPetMod(xi.mod.DEX, 2)
    target:addPetMod(xi.mod.VIT, 3)
    target:addPetMod(xi.mod.FOOD_ACCP, 10)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 105)
    target:addPetMod(xi.mod.FOOD_RACCP, 10)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 105)
    target:addPetMod(xi.mod.MACC, 75)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 80)
    target:delMod(xi.mod.FOOD_RACCP, 10)
    target:delMod(xi.mod.FOOD_RACC_CAP, 80)
    target:delMod(xi.mod.MACC, 50)
    target:delPetMod(xi.mod.HP, 20)
    target:delPetMod(xi.mod.DEX, 2)
    target:delPetMod(xi.mod.VIT, 3)
    target:delPetMod(xi.mod.FOOD_ACCP, 10)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 105)
    target:delPetMod(xi.mod.FOOD_RACCP, 10)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 105)
    target:delPetMod(xi.mod.MACC, 75)
end

return itemObject
