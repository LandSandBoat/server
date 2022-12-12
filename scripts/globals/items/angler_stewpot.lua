-----------------------------------
-- ID: 5611
-- Item: Angler's Stewpot
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP +10% (cap 200)
-- MP +10
-- HP Recoverd while healing 5
-- MP Recovered while healing 1
-- Accuracy +15% Cap 15
-- Ranged Accuracy 15% Cap 15
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5611)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 200)
    target:addMod(xi.mod.MP, 10)
    target:addMod(xi.mod.HPHEAL, 5)
    target:addMod(xi.mod.MPHEAL, 1)
    target:addMod(xi.mod.FOOD_ACCP, 15)
    target:addMod(xi.mod.FOOD_ACC_CAP, 15)
    target:addMod(xi.mod.FOOD_RACCP, 15)
    target:addMod(xi.mod.FOOD_RACC_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 200)
    target:delMod(xi.mod.MP, 10)
    target:delMod(xi.mod.HPHEAL, 5)
    target:delMod(xi.mod.MPHEAL, 1)
    target:delMod(xi.mod.FOOD_ACCP, 15)
    target:delMod(xi.mod.FOOD_ACC_CAP, 15)
    target:delMod(xi.mod.FOOD_RACCP, 15)
    target:delMod(xi.mod.FOOD_RACC_CAP, 15)
end

return itemObject
