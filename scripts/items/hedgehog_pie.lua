-----------------------------------
-- ID: 5146
-- Item: hedgehog_pie
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 55
-- Strength 6
-- Vitality 2
-- Intelligence -3
-- Mind 3
-- Magic Regen While Healing 2
-- Health Regen While Healing 2
-- Attack % 18
-- Attack Cap 90
-- Accuracy 5
-- Ranged ATT % 18
-- Ranged ATT Cap 90
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
    effect:addMod(xi.mod.FOOD_HP, 55)
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.MND, 3)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 2)
    effect:addMod(xi.mod.FOOD_ATTP, 18)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 90)
    effect:addMod(xi.mod.ACC, 5)
    effect:addMod(xi.mod.FOOD_RATTP, 18)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 90)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
