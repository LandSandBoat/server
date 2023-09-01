-----------------------------------
-- ID: 5622
-- Item: Candy Cane
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- Intelligence 4
-- Mind 4
-- MP Recovery while healing 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5622)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 4)
    target:addMod(xi.mod.MND, 4)
    target:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 4)
    target:delMod(xi.mod.MND, 4)
    target:delMod(xi.mod.MPHEAL, 2)
end

return itemObject
