-----------------------------------
-- ID: 5154
-- Item: Tavnazian Sheep Liver
-- Food Effect: 5Min, Galka only
-----------------------------------
-- Strength 2
-- Intelligence -4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_MEAT)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 2)
    effect:addMod(xi.mod.INT, -4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
