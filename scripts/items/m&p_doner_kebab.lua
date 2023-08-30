-----------------------------------
-- ID: 5717
-- Item: M&P Doner Kabob
-- Food Effect: 5Min, All Races
-----------------------------------
-- HP 5% (cap 150)
-- MP 5% (cap 150)
-- hHP +2
-- hMP +2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5717)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 5)
    target:addMod(xi.mod.FOOD_HP_CAP, 150)
    target:addMod(xi.mod.FOOD_MPP, 5)
    target:addMod(xi.mod.FOOD_MP_CAP, 150)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 5)
    target:delMod(xi.mod.FOOD_HP_CAP, 150)
    target:delMod(xi.mod.FOOD_MPP, 5)
    target:delMod(xi.mod.FOOD_MP_CAP, 150)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 2)
end

return itemObject
