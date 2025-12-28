-----------------------------------
-- ID: 5693
-- Item: plate_of_octopus_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 1
-- Accuracy % 14 (cap 68)
-- Ranged Accuracy % 14 (cap 68)
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
    effect:addMod(xi.mod.STR, 1)
    effect:addMod(xi.mod.FOOD_ACCP, 14)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 68)
    effect:addMod(xi.mod.FOOD_RACCP, 14)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 68)
    effect:addMod(xi.mod.SLEEPRES, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
