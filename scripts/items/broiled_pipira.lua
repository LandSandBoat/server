-----------------------------------
-- ID: 4585
-- Item: Broiled Pipira
-- Food Effect: 60Min, All Races
-----------------------------------
-- Dexterity 4
-- Mind -1
-- Attack % 14 (cap 80)
-- Ranged ATT % 14 (cap 80)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4585)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_ATTP, 14)
    target:addMod(xi.mod.FOOD_ATT_CAP, 80)
    target:addMod(xi.mod.FOOD_RATTP, 14)
    target:addMod(xi.mod.FOOD_RATT_CAP, 80)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_ATTP, 14)
    target:delMod(xi.mod.FOOD_ATT_CAP, 80)
    target:delMod(xi.mod.FOOD_RATTP, 14)
    target:delMod(xi.mod.FOOD_RATT_CAP, 80)
end

return itemObject
