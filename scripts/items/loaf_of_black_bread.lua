-----------------------------------
-- ID: 4364
-- Item: loaf_of_black_bread
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 8
-- Dexterity -1
-- Vitality 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4364)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 8)
    target:addMod(xi.mod.DEX, -1)
    target:addMod(xi.mod.VIT, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 8)
    target:delMod(xi.mod.DEX, -1)
    target:delMod(xi.mod.VIT, 2)
end

return itemObject
