-----------------------------------
-- ID: 6069
-- Item: Bowl of Riverfin Soup
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- Accuracy % 14 Cap 90
-- Ranged Accuracy % 14 Cap 90
-- Attack % 18 Cap 80
-- Ranged Attack % 18 Cap 80
-- Amorph Killer 5
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 6069)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_ACCP, 14)
    target:addMod(xi.mod.FOOD_ACC_CAP, 90)
    target:addMod(xi.mod.FOOD_RACCP, 14)
    target:addMod(xi.mod.FOOD_RACC_CAP, 90)
    target:addMod(xi.mod.FOOD_ATTP, 18)
    target:addMod(xi.mod.FOOD_ATT_CAP, 80)
    target:addMod(xi.mod.FOOD_RATTP, 18)
    target:addMod(xi.mod.FOOD_RATT_CAP, 80)
    target:addMod(xi.mod.AMORPH_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_ACCP, 14)
    target:delMod(xi.mod.FOOD_ACC_CAP, 90)
    target:delMod(xi.mod.FOOD_RACCP, 14)
    target:delMod(xi.mod.FOOD_RACC_CAP, 90)
    target:delMod(xi.mod.FOOD_ATTP, 18)
    target:delMod(xi.mod.FOOD_ATT_CAP, 80)
    target:delMod(xi.mod.FOOD_RATTP, 18)
    target:delMod(xi.mod.FOOD_RATT_CAP, 80)
    target:delMod(xi.mod.AMORPH_KILLER, 5)
end

return itemObject
