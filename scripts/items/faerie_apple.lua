-----------------------------------
-- ID: 4363
-- Item: faerie_apple
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility -4
-- Intelligence 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4363)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, -4)
    target:addMod(xi.mod.INT, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, -4)
    target:delMod(xi.mod.INT, 2)
end

return itemObject
