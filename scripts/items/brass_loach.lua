-----------------------------------
-- ID: 5469
-- Item: Brass Loach
-- Food Effect: 5 Min, Mithra only
-----------------------------------
-- Dexterity +2
-- Mind +4
-- Evasion +5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_FISH)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5469)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.MND, 4)
    target:addMod(xi.mod.EVA, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.MND, 4)
    target:delMod(xi.mod.EVA, 5)
end

return itemObject
