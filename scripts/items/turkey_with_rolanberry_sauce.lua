-----------------------------------
-- ID: 6576
-- Item: rolanberry_turkey
-- Food Effect: 4 Hours, All Races
-----------------------------------
-- STR +10
-- Attack +20% (Max. 120)
-- Ranged Attack +20% (Max. 120)
-- "Counter" +10
-- "Resist Amnesia" +10
-- https://www.bg-wiki.com/ffxi/Rol._Turkey
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 6576)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 10)
    target:addMod(xi.mod.FOOD_ATTP, 20)
    target:addMod(xi.mod.FOOD_ATT_CAP, 120)
    target:addMod(xi.mod.FOOD_RATTP, 20)
    target:addMod(xi.mod.FOOD_RATT_CAP, 120)
    target:addMod(xi.mod.COUNTER, 10)
    target:addMod(xi.mod.AMNESIARES, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 10)
    target:delMod(xi.mod.FOOD_ATTP, 20)
    target:delMod(xi.mod.FOOD_ATT_CAP, 120)
    target:delMod(xi.mod.FOOD_RATTP, 20)
    target:delMod(xi.mod.FOOD_RATT_CAP, 120)
    target:delMod(xi.mod.COUNTER, 10)
    target:delMod(xi.mod.AMNESIARES, 10)
end

return itemObject
