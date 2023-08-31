-----------------------------------
-- ID: 4490
-- Item: Pickled Herring
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 3
-- Mind -3
-- Attack % 12 (cap 70)
-- Ranged ATT % 12 (cap 70)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4490)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.FOOD_ATTP, 12)
    target:addMod(xi.mod.FOOD_ATT_CAP, 70)
    target:addMod(xi.mod.FOOD_RATTP, 12)
    target:addMod(xi.mod.FOOD_RATT_CAP, 70)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.FOOD_ATTP, 12)
    target:delMod(xi.mod.FOOD_ATT_CAP, 70)
    target:delMod(xi.mod.FOOD_RATTP, 12)
    target:delMod(xi.mod.FOOD_RATT_CAP, 70)
end

return itemObject
