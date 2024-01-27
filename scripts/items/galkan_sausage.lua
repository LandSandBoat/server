-----------------------------------
-- ID: 4395
-- Item: galkan_sausage
-- Food Effect: 30Min, All Races
-----------------------------------
-- Multi-Race Effects
-- Galka
-- Strength 3
-- Intelligence -1
-- Attack % 25
-- Attack Cap 30
-- Ranged ATT % 25
-- Ranged ATT Cap 30
--
-- Other
-- Strength 3
-- Intelligence -4
-- Attack 9
-- Ranged ATT  9
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4395)
end

itemObject.onEffectGain = function(target, effect)
    if target:getRace() ~= xi.race.GALKA then
        target:addMod(xi.mod.STR, 3)
        target:addMod(xi.mod.INT, -4)
        target:addMod(xi.mod.ATT, 9)
        target:addMod(xi.mod.RATT, 9)
    else
        target:addMod(xi.mod.STR, 3)
        target:addMod(xi.mod.INT, -1)
        target:addMod(xi.mod.FOOD_ATTP, 25)
        target:addMod(xi.mod.FOOD_ATT_CAP, 30)
        target:addMod(xi.mod.FOOD_RATTP, 25)
        target:addMod(xi.mod.FOOD_RATT_CAP, 30)
    end
end

itemObject.onEffectLose = function(target, effect)
    if target:getRace() ~= xi.race.GALKA then
        target:delMod(xi.mod.STR, 3)
        target:delMod(xi.mod.INT, -4)
        target:delMod(xi.mod.ATT, 9)
        target:delMod(xi.mod.RATT, 9)
    else
        target:delMod(xi.mod.STR, 3)
        target:delMod(xi.mod.INT, -1)
        target:delMod(xi.mod.FOOD_ATTP, 25)
        target:delMod(xi.mod.FOOD_ATT_CAP, 30)
        target:delMod(xi.mod.FOOD_RATTP, 25)
        target:delMod(xi.mod.FOOD_RATT_CAP, 30)
    end
end

return itemObject
