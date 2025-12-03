-----------------------------------
-- ID: 5196
-- Item: strip_of_buffalo_jerky
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 4
-- Mind -2
-- Attack % 18
-- Attack Cap 65
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
    effect:addMod(xi.mod.STR, 4)
    effect:addMod(xi.mod.MND, -2)
    effect:addMod(xi.mod.FOOD_ATTP, 18)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 65)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
