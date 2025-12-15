-----------------------------------
-- ID: 5665
-- Item: plate_of_fin_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Intelligence 5
-- Accuracy % 16 (cap 76)
-- Ranged Accuracy % 16 (cap 76)
-- Resist Sleep +1
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
    effect:addMod(xi.mod.INT, 5)
    effect:addMod(xi.mod.FOOD_ACCP, 16)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 76)
    effect:addMod(xi.mod.FOOD_RACCP, 16)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 76)
    effect:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
