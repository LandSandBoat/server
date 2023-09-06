-----------------------------------
-- ID: 4413
-- Item: Apple Pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 25
-- Agility -1
-- Intelligence 3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4413)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 25)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 25)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, 3)
end

return itemObject
