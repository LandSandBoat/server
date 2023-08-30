-----------------------------------
-- ID: 4394
-- Item: ginger_cookie
-- Food Effect: 3Min, All Races
-----------------------------------
-- Magic Regen While Healing 5
-- Plantoid Killer 10
-- Slow Resist 10
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 4394)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 5)
    target:addMod(xi.mod.PLANTOID_KILLER, 10)
    target:addMod(xi.mod.SLOWRES, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 5)
    target:delMod(xi.mod.PLANTOID_KILLER, 10)
    target:delMod(xi.mod.SLOWRES, 10)
end

return itemObject
