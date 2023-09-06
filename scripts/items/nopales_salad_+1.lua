-----------------------------------
-- ID: 5702
-- Item: Nopales Salad +1
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Strength 2
-- Agility 7
-- Ranged Accuracy +25
-- Ranged Attack +15
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5702)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.AGI, 7)
    target:addMod(xi.mod.RACC, 25)
    target:addMod(xi.mod.RATT, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.AGI, 7)
    target:delMod(xi.mod.RACC, 25)
    target:delMod(xi.mod.RATT, 15)
end

return itemObject
