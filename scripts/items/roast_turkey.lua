-----------------------------------
-- ID: 5620
-- Item: roast_turkey
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength 4
-- Vitality 4
-- hMP +2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5620)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.HPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.HPHEAL, 2)
end

return itemObject
