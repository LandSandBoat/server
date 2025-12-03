-----------------------------------
-- ID: 6070
-- Item: Bowl of Oceanfin Soup
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- Accuracy % 15 Cap 95
-- Ranged Accuracy % 15 Cap 95
-- Attack % 19 Cap 85
-- Ranged Attack % 19 Cap 85
-- Amorph Killer 6
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 95)
    effect:addMod(xi.mod.FOOD_RACCP, 15)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 95)
    effect:addMod(xi.mod.FOOD_ATTP, 19)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 85)
    effect:addMod(xi.mod.FOOD_RATTP, 19)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 85)
    effect:addMod(xi.mod.AMORPH_KILLER, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
