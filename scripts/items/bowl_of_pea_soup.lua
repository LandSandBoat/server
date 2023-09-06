-----------------------------------
-- ID: 4416
-- Item: bowl_of_pea_soup
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Vitality -1
-- Agility 1
-- Ranged Accuracy 5
-- HP Recovered While Healing 3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4416)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.RACC, 5)
    target:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.RACC, 5)
    target:delMod(xi.mod.HPHEAL, 3)
end

return itemObject
