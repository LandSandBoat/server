-----------------------------------
-- ID: 5758
-- Item: black_curry_bun
-- Food Effect: 30minutes, All Races
-----------------------------------
-- TODO: Group effects
-- DEX +2
-- VIT +4
-- INT +1
-- Accuracy +5
-- Ranged Accuracy +5
-- Evasion +5
-- DEF +15% (cap 180)
-- Resist Sleep +3
-- hHP +2
-- hMP +1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5758)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.INT, 1)
    target:addMod(xi.mod.ACC, 5)
    target:addMod(xi.mod.RACC, 5)
    target:addMod(xi.mod.EVA, 5)
    target:addMod(xi.mod.FOOD_DEFP, 15)
    target:addMod(xi.mod.FOOD_DEF_CAP, 180)
    target:addMod(xi.mod.SLEEPRES, 3)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.INT, 1)
    target:delMod(xi.mod.ACC, 5)
    target:delMod(xi.mod.RACC, 5)
    target:delMod(xi.mod.EVA, 5)
    target:delMod(xi.mod.FOOD_DEFP, 15)
    target:delMod(xi.mod.FOOD_DEF_CAP, 180)
    target:delMod(xi.mod.SLEEPRES, 3)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
