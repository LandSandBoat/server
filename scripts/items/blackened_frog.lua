-----------------------------------
-- ID: 4536
-- Item: Blackened Frog
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 2
-- Agility 2
-- Mind -2
-- Attack % 14
-- Attack Cap 75
-- Ranged ATT % 14
-- Ranged ATT Cap 75
-- Evasion +5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4536)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.AGI, 2)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.FOOD_ATTP, 14)
    target:addMod(xi.mod.FOOD_ATT_CAP, 75)
    target:addMod(xi.mod.FOOD_RATTP, 14)
    target:addMod(xi.mod.FOOD_RATT_CAP, 75)
    target:addMod(xi.mod.EVA, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.AGI, 2)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.FOOD_ATTP, 14)
    target:delMod(xi.mod.FOOD_ATT_CAP, 75)
    target:delMod(xi.mod.FOOD_RATTP, 14)
    target:delMod(xi.mod.FOOD_RATT_CAP, 75)
    target:delMod(xi.mod.EVA, 5)
end

return itemObject
