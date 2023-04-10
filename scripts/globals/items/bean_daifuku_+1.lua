-----------------------------------
-- ID: 6342
-- Item: bean_daifuku_+1
-- Food Effect: 60 Min, All Races
-----------------------------------
-- HP +30
-- VIT +4
-- Accuracy +11% (cap 54)
-- Ranged Accuracy +11% (cap 54)
-- Pet:
-- HP +30
-- VIT +4
-- Accuracy +11% (cap 81)
-- Ranged Accuracy +11% (cap 81)
-- Haste +4%
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 6342)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 54)
    target:addMod(xi.mod.FOOD_RACCP, 11)
    target:addMod(xi.mod.FOOD_RACC_CAP, 54)
    target:addPetMod(xi.mod.HP, 30)
    target:addPetMod(xi.mod.VIT, 4)
    target:addPetMod(xi.mod.FOOD_ACCP, 11)
    target:addPetMod(xi.mod.FOOD_ACC_CAP, 81)
    target:addPetMod(xi.mod.FOOD_RACCP, 11)
    target:addPetMod(xi.mod.FOOD_RACC_CAP, 81)
    target:addPetMod(xi.mod.HASTE_GEAR, 400)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 54)
    target:delMod(xi.mod.FOOD_RACCP, 11)
    target:delMod(xi.mod.FOOD_RACC_CAP, 54)
    target:delPetMod(xi.mod.HP, 30)
    target:delPetMod(xi.mod.VIT, 4)
    target:delPetMod(xi.mod.FOOD_ACCP, 11)
    target:delPetMod(xi.mod.FOOD_ACC_CAP, 81)
    target:delPetMod(xi.mod.FOOD_RACCP, 11)
    target:delPetMod(xi.mod.FOOD_RACC_CAP, 81)
    target:delPetMod(xi.mod.HASTE_GEAR, 400)
end

return itemObject
