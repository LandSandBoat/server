-----------------------------------
-- ID: 5602
-- Item: dish_of_hydra_kofte
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 7
-- Intelligence -3
-- Attack % 20
-- Attack Cap 150
-- Defense % 25
-- Defense Cap 70
-- Ranged ATT % 20
-- Ranged ATT Cap 150
-- Poison Resist 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5602)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 7)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.FOOD_ATTP, 20)
    target:addMod(xi.mod.FOOD_ATT_CAP, 150)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 70)
    target:addMod(xi.mod.FOOD_RATTP, 20)
    target:addMod(xi.mod.FOOD_RATT_CAP, 150)
    target:addMod(xi.mod.POISONRES, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 7)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.FOOD_ATTP, 20)
    target:delMod(xi.mod.FOOD_ATT_CAP, 150)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 70)
    target:delMod(xi.mod.FOOD_RATTP, 20)
    target:delMod(xi.mod.FOOD_RATT_CAP, 150)
    target:delMod(xi.mod.POISONRES, 5)
end

return itemObject
