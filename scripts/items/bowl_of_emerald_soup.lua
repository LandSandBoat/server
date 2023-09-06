-----------------------------------
-- ID: 4327
-- Item: Bowl of Emerald Soup
-- Food Effect: 240Min, All Races
-----------------------------------
-- Agility 2
-- Vitality -1
-- Health Regen While Healing 3
-- Ranged ACC 6
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4327)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.HPHEAL, 3)
    target:addMod(xi.mod.RACC, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.HPHEAL, 3)
    target:delMod(xi.mod.RACC, 6)
end

return itemObject
