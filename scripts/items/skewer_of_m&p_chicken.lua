-----------------------------------
-- ID: 5639
-- Item: Skewer of M&P Chicken
-- Food Effect: 3Min, All Races
-----------------------------------
-- Strength 5
-- Intelligence -5
-- Attack % 25
-- Attack Cap 154
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.INT, -5)
    effect:addMod(xi.mod.FOOD_ATTP, 25)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 154)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
