-----------------------------------
-- ID: 6599
-- Item: egg_sandwich
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP % 10
-- HP Cap 100
-- Vitality 5
-- Mind 5
-- Accuracy % 10
-- Accuracy Cap 50
-- Defense % 10
-- Defense Cap 100
-- Enmity 1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 100)
    target:addMod(xi.mod.VIT, 5)
    target:addMod(xi.mod.MND, 5)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 50)
    target:addMod(xi.mod.FOOD_DEFP, 10)
    target:addMod(xi.mod.FOOD_DEF_CAP, 100)
    target:addMod(xi.mod.ENMITY, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 100)
    target:delMod(xi.mod.VIT, 5)
    target:delMod(xi.mod.MND, 5)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 50)
    target:delMod(xi.mod.FOOD_DEFP, 10)
    target:delMod(xi.mod.FOOD_DEF_CAP, 100)
    target:delMod(xi.mod.ENMITY, 1)
end

return itemObject
