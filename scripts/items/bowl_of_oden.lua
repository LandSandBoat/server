-----------------------------------
-- ID: 6470
-- Item: bowl_of_oden
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 5
-- Intelligence 5
-- Accuracy % 15
-- Accuracy Cap 70
-- Magic Accuracy % 15
-- Magic Accuracy Cap 70
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
    target:addMod(xi.mod.DEX, 5)
    target:addMod(xi.mod.INT, 5)
    target:addMod(xi.mod.FOOD_ACCP, 15)
    target:addMod(xi.mod.FOOD_ACC_CAP, 70)
    target:addMod(xi.mod.FOOD_MACCP, 15)
    target:addMod(xi.mod.FOOD_MACC_CAP, 70)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 5)
    target:delMod(xi.mod.INT, 5)
    target:delMod(xi.mod.FOOD_ACCP, 15)
    target:delMod(xi.mod.FOOD_ACC_CAP, 70)
    target:delMod(xi.mod.FOOD_MACCP, 15)
    target:delMod(xi.mod.FOOD_MACC_CAP, 70)
end

return itemObject
