-----------------------------------
-- ID: 4371
-- Item: slice_of_grilled_hare
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 2
-- Intelligence -1
-- Attack % 30
-- Attack Cap 15
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
    effect:addMod(xi.mod.STR, 2)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.FOOD_ATTP, 30)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
