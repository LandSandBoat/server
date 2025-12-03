-----------------------------------
-- ID: 4537
-- Item: roast_carp
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 1
-- Mind -1
-- Ranged ATT % 14 (cap 40)
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
    effect:addMod(xi.mod.DEX, 1)
    effect:addMod(xi.mod.MND, -1)
    effect:addMod(xi.mod.FOOD_RATTP, 14)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 40)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
