-----------------------------------
-- ID: 4407
-- Item: carp_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 1
-- Accuracy % 10 (cap 52)
-- HP Recovered While Healing 2
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
    effect:addMod(xi.mod.FOOD_ACCP, 10)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 52)
    effect:addMod(xi.mod.HPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
