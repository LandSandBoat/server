-----------------------------------
-- ID: 4516
-- Item: slice_of_grilled_black_hare
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength 2
-- Intelligence -1
-- Attack % 20
-- Attack Cap 30
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
    effect:addMod(xi.mod.STR, 2)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.FOOD_ATTP, 20)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
