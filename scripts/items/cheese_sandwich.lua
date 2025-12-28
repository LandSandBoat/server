-----------------------------------
-- ID: 5686
-- Item: cheese_sandwich
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP 10
-- Agility 1
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
    effect:addMod(xi.mod.FOOD_HP, 10)
    effect:addMod(xi.mod.AGI, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
