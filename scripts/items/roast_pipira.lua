-----------------------------------
-- ID: 4538
-- Item: roast_pipira
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 3
-- Mind -3
-- Attack % 14
-- Attack Cap 75
-- Ranged ATT % 14
-- Ranged ATT Cap 75
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
    effect:addMod(xi.mod.DEX, 3)
    effect:addMod(xi.mod.MND, -3)
    effect:addMod(xi.mod.FOOD_ATTP, 14)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 75)
    effect:addMod(xi.mod.FOOD_RATTP, 14)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 75)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
