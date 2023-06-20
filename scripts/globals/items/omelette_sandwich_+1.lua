-----------------------------------
-- ID: 6602
-- Item: Omelette Sandwich +1
-- Food Effect: 30minutes, All Races
-----------------------------------
-- HP +11% (Max. 155)
-- VIT +8
-- MND +8
-- Accuracy +11% (Max. 85)
-- DEF +11% (Max. 125)
-- Enmity +5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6602)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 11)
    target:addMod(xi.mod.FOOD_HP_CAP, 155)
    target:addMod(xi.mod.VIT, 8)
    target:addMod(xi.mod.MND, 8)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 85)
    target:addMod(xi.mod.FOOD_DEFP, 11)
    target:addMod(xi.mod.FOOD_DEF_CAP, 125)
    target:addMod(xi.mod.ENMITY, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 11)
    target:delMod(xi.mod.FOOD_HP_CAP, 155)
    target:delMod(xi.mod.VIT, 8)
    target:delMod(xi.mod.MND, 8)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 85)
    target:delMod(xi.mod.FOOD_DEFP, 11)
    target:delMod(xi.mod.FOOD_DEF_CAP, 125)
    target:delMod(xi.mod.ENMITY, 5)
end

return itemObject
