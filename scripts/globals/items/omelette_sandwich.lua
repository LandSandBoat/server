-----------------------------------
-- ID: 6601
-- Item: Omelette Sandwich
-- Food Effect: 30minutes, All Races
-----------------------------------
-- HP +11% (Max. 150)
-- VIT +7
-- MND +7
-- Accuracy +11% (Max. 80)
-- DEF +11% (Max. 120)
-- Enmity +4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6601)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 11)
    target:addMod(xi.mod.FOOD_HP_CAP, 150)
    target:addMod(xi.mod.VIT, 7)
    target:addMod(xi.mod.MND, 7)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 80)
    target:addMod(xi.mod.FOOD_DEFP, 11)
    target:addMod(xi.mod.FOOD_DEF_CAP, 120)
    target:addMod(xi.mod.ENMITY, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 11)
    target:delMod(xi.mod.FOOD_HP_CAP, 150)
    target:delMod(xi.mod.VIT, 7)
    target:delMod(xi.mod.MND, 7)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 80)
    target:delMod(xi.mod.FOOD_DEFP, 11)
    target:delMod(xi.mod.FOOD_DEF_CAP, 120)
    target:delMod(xi.mod.ENMITY, 4)
end

return itemObject
