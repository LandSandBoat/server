-----------------------------------
-- ID: 5590
-- Item: Balik Sandvici
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 3
-- Agility 1
-- Intelligence 3
-- Mind -2
-- Ranged ACC 5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5590)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.RACC, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.RACC, 5)
end

return itemObject
