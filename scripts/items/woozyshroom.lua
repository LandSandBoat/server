-----------------------------------
-- ID: 4373
-- Item: woozyshroom
-- Food Effect: 5Min, All Races
-----------------------------------
-- Strength -4
-- Mind 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4373)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, -4)
    target:addMod(xi.mod.MND, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, -4)
    target:delMod(xi.mod.MND, 2)
end

return itemObject
