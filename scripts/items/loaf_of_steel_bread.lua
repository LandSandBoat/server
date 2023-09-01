-----------------------------------
-- ID: 4573
-- Item: loaf_of_steel_bread
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 6
-- Vitality 1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4573)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 6)
    target:addMod(xi.mod.VIT, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 6)
    target:delMod(xi.mod.VIT, 1)
end

return itemObject
