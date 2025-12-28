-----------------------------------
-- ID: 6069
-- Item: Bowl of Riverfin Soup
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- Accuracy % 14 Cap 90
-- Ranged Accuracy % 14 Cap 90
-- Attack % 18 Cap 80
-- Ranged Attack % 18 Cap 80
-- Amorph Killer 5
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_ACCP, 14)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 90)
    effect:addMod(xi.mod.FOOD_RACCP, 14)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 90)
    effect:addMod(xi.mod.FOOD_ATTP, 18)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 80)
    effect:addMod(xi.mod.FOOD_RATTP, 18)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 80)
    effect:addMod(xi.mod.AMORPH_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
