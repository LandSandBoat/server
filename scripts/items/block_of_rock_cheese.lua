-----------------------------------
-- ID: 4593
-- Item: Block of Rock Cheese
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 6
-- Health Cap 45
-- HP Recovered while healing 1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4593)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 6)
    target:addMod(xi.mod.FOOD_HP_CAP, 45)
    target:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 6)
    target:delMod(xi.mod.FOOD_HP_CAP, 45)
    target:delMod(xi.mod.HPHEAL, 1)
end

return itemObject
