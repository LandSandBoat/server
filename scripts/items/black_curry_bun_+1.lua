-----------------------------------
-- ID: 5764
-- Item: black_curry_bun+1
-- Food Effect: 60 min, All Races
-----------------------------------
-- TODO: Group effects
-- Dexterity +4
-- Vitality +6
-- Intelligence +3
-- Mind +1
-- Accuracy +7
-- Ranged Accuracy +7
-- Evasion +7
-- Defense +25% (cap 200)
-- Resist Sleep +5
-- hHP +6
-- hMP +3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5764)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.VIT, 6)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.MND, 1)
    target:addMod(xi.mod.ACC, 7)
    target:addMod(xi.mod.RACC, 7)
    target:addMod(xi.mod.EVA, 7)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 200)
    target:addMod(xi.mod.SLEEPRES, 5)
    target:addMod(xi.mod.HPHEAL, 6)
    target:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.VIT, 6)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.MND, 1)
    target:delMod(xi.mod.ACC, 7)
    target:delMod(xi.mod.RACC, 7)
    target:delMod(xi.mod.EVA, 7)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 200)
    target:delMod(xi.mod.SLEEPRES, 5)
    target:delMod(xi.mod.HPHEAL, 6)
    target:delMod(xi.mod.MPHEAL, 3)
end

return itemObject
