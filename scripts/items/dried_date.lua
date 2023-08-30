-----------------------------------
-- ID: 5567
-- Item: dried_date
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 10
-- Magic 20
-- Agility -1
-- Intelligence 3
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5567)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 10)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 10)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, 3)
end

return itemObject
