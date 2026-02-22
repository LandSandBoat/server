-----------------------------------
-- ID: 5680
-- Item: agaricus mushroom
-- Food Effect: 5 Min, All Races
-----------------------------------
-- STR -4
-- MND +2
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 300, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, -4)
    effect:addMod(xi.mod.MND, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
