-----------------------------------
-- ID: 4465
-- Item: bowl_of_goblin_stew
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Dexterity -4
-- Attack +16% (cap 80)
-- Ranged Attack +16% (cap 80)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4465)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, -4)
    target:addMod(xi.mod.FOOD_ATTP, 16)
    target:addMod(xi.mod.FOOD_ATT_CAP, 80)
    target:addMod(xi.mod.FOOD_RATTP, 16)
    target:addMod(xi.mod.FOOD_RATT_CAP, 80)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, -4)
    target:delMod(xi.mod.FOOD_ATTP, 16)
    target:delMod(xi.mod.FOOD_ATT_CAP, 80)
    target:delMod(xi.mod.FOOD_RATTP, 16)
    target:delMod(xi.mod.FOOD_RATT_CAP, 80)
end

return itemObject
