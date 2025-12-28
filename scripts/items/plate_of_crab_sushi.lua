-----------------------------------
-- ID: 5721
-- Item: plate_of_crab_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Vitality 1
-- Defense 10
-- Accuracy % 13 (cap 64)
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
    effect:addMod(xi.mod.VIT, 1)
    effect:addMod(xi.mod.DEF, 10)
    effect:addMod(xi.mod.FOOD_ACCP, 13)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 64)
    effect:addMod(xi.mod.SLEEPRES, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
