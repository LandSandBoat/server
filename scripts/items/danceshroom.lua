-----------------------------------
-- ID: 4375
-- Item: danceshroom
-- Food Effect: 5Min, All Races
-----------------------------------
-- Strength -5
-- Mind 3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, -5)
    effect:addMod(xi.mod.MND, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
