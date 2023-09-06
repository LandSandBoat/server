-----------------------------------
-- ID: 4576
-- Item: wizard_cookie
-- Food Effect: 5Min, All Races
-----------------------------------
-- MP Recovered While Healing 7
-- Plantoid Killer 12
-- Slow Resist 12
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4576)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 7)
    target:addMod(xi.mod.PLANTOID_KILLER, 12)
    target:addMod(xi.mod.SLOWRES, 12)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 7)
    target:delMod(xi.mod.PLANTOID_KILLER, 12)
    target:delMod(xi.mod.SLOWRES, 12)
end

return itemObject
