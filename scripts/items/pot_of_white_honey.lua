-----------------------------------
-- ID: 5562
-- Item: pot_of_white_honey
-- Food Effect: 5Min, All Races
-----------------------------------
-- Magic Regen While Healing 1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5562)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
