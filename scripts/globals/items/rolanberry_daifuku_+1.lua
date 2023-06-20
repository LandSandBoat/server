-----------------------------------
-- ID: 6340
-- Item: rolanberry_daifuku_+1
-- Food Effect: 60 Min, All Races
-----------------------------------
-- HP +30
-- DEX +3
-- VIT +4
-- Accuracy +11% (cap 85)
-- Ranged Accuracy +11% (cap 85)
-- Magic Accuracy +55
-- Pet:
-- HP +30
-- DEX +3
-- VIT +4
-- Accuracy +11% (cap 110)
-- Ranged Accuracy +11% (cap 110)
-- Magic Accuracy +80
-- https://www.bg-wiki.com/bg/Rolan._Daifuku_%2B1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6340)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 85)
    target:addMod(xi.mod.FOOD_RACCP, 11)
    target:addMod(xi.mod.FOOD_RACC_CAP, 85)
    target:addMod(xi.mod.MACC, 55)
    target:addPetMod(xi.mod.HP, 30)
    target:addPetMod(xi.mod.DEX, 3)
    target:addPetMod(xi.mod.VIT, 4)
    target:addPetMod(xi.mod.FOOD_ACCP, 11)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 110)
    target:addPetMod(xi.mod.FOOD_RACCP, 11)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 110)
    target:addPetMod(xi.mod.MACC, 80)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 85)
    target:delMod(xi.mod.FOOD_RACCP, 11)
    target:delMod(xi.mod.FOOD_RACC_CAP, 85)
    target:delMod(xi.mod.MACC, 55)
    target:delPetMod(xi.mod.HP, 30)
    target:delPetMod(xi.mod.DEX, 3)
    target:delPetMod(xi.mod.VIT, 4)
    target:delPetMod(xi.mod.FOOD_ACCP, 11)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 110)
    target:delPetMod(xi.mod.FOOD_RACCP, 11)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 110)
    target:delPetMod(xi.mod.MACC, 80)
end

return itemObject
