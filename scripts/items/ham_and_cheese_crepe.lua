-----------------------------------
-- ID: 5771
-- Item: ham_and_cheese_crepe
-- Food Effect: 30 Min, All Races
-----------------------------------
-- HP +10% (cap 25)
-- STR +2
-- VIT +1
-- Magic Accuracy +10
-- Magic Defense +3
-- hHP +2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5771)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 10)
    target:addMod(xi.mod.FOOD_HP_CAP, 25)
    target:addMod(xi.mod.STR, 2)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.MACC, 10)
    target:addMod(xi.mod.MDEF, 3)
    target:addMod(xi.mod.HPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 10)
    target:delMod(xi.mod.FOOD_HP_CAP, 25)
    target:delMod(xi.mod.STR, 2)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.MACC, 10)
    target:delMod(xi.mod.MDEF, 3)
    target:delMod(xi.mod.HPHEAL, 2)
end

return itemObject
