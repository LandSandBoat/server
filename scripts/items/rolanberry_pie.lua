-----------------------------------
-- ID: 4414
-- Item: rolanberry_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 50
-- Agility -1
-- Intelligence 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4414)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 50)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 50)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, 2)
end

return itemObject
