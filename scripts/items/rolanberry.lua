-----------------------------------
-- ID: 4365
-- Item: rolanberry
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4365)
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
