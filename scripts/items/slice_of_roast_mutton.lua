-----------------------------------
-- ID: 4437
-- Item: slice_of_roast_mutton
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 3
-- Intelligence -1
-- Attack % 27
-- Attack Cap 30
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
    effect:addMod(xi.mod.STR, 3)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.FOOD_ATTP, 27)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
