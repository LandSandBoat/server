-----------------------------------
-- ID: 5718
-- Item: Cream Puff
-- Food Effect: 30 mintutes, All Races
-----------------------------------
-- Intelligence +7
-- HP -10
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5718)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 7)
    target:addMod(xi.mod.HP, -10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 7)
    target:delMod(xi.mod.HP, -10)
end

return itemObject
