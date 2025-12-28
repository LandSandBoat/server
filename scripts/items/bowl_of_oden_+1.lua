-----------------------------------
-- ID: 6471
-- Item: bowl_of_oden_+1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 6
-- Intelligence 6
-- Accuracy % 16
-- Accuracy Cap 75
-- Magic Accuracy % 16
-- Magic Accuracy Cap 75
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
    effect:addMod(xi.mod.DEX, 6)
    effect:addMod(xi.mod.INT, 6)
    effect:addMod(xi.mod.FOOD_ACCP, 16)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 75)
    effect:addMod(xi.mod.FOOD_MACCP, 16)
    effect:addMod(xi.mod.FOOD_MACC_CAP, 75)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
