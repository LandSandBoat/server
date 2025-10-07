-----------------------------------
-- ID: 6600
-- Item: egg_sandwich_+1
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP % 10
-- HP Cap 105
-- Vitality 6
-- Mind 6
-- Accuracy % 10
-- Accuracy Cap 55
-- Defense % 10
-- Defense Cap 105
-- Enmity 2
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
    target:addMod(xi.mod.FOOD_HP_CAP, 105)
    target:addMod(xi.mod.VIT, 6)
    target:addMod(xi.mod.MND, 6)
    target:addMod(xi.mod.FOOD_ACCP, 10)
    target:addMod(xi.mod.FOOD_ACC_CAP, 55)
    target:addMod(xi.mod.FOOD_DEFP, 10)
    target:addMod(xi.mod.FOOD_DEF_CAP, 105)
    target:addMod(xi.mod.ENMITY, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 105)
    target:delMod(xi.mod.VIT, 6)
    target:delMod(xi.mod.MND, 6)
    target:delMod(xi.mod.FOOD_ACCP, 10)
    target:delMod(xi.mod.FOOD_ACC_CAP, 55)
    target:delMod(xi.mod.FOOD_DEFP, 10)
    target:delMod(xi.mod.FOOD_DEF_CAP, 105)
    target:delMod(xi.mod.ENMITY, 2)
end

return itemObject
