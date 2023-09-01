-----------------------------------
-- ID: 5648
-- Item: Grilled Lik
-- Food Effect: 60 Mins, All Races
-----------------------------------
-- Dexterity 4
-- Mind -3
-- Accuracy +2
-- Attack +8
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5648)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.ACC, 2)
    target:addMod(xi.mod.ATT, 8)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.ACC, 2)
    target:delMod(xi.mod.ATT, 8)
end

return itemObject
