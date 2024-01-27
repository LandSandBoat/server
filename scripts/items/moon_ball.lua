-----------------------------------
-- ID: 4568
-- Item: moon_ball
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 3
-- Magic 3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4568)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 3)
    target:addMod(xi.mod.MP, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 3)
    target:delMod(xi.mod.MP, 3)
end

return itemObject
