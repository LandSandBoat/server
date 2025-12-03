-----------------------------------
-- ID: 4377
-- Item: slice_of_coeurl_meat
-- Food Effect: 5Min, Galka only
-----------------------------------
-- Strength 5
-- Intelligence -7
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
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.INT, -7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
