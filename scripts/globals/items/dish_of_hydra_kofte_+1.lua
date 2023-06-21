-----------------------------------
-- ID: 5603
-- Item: dish_of_hydra_kofte_+1
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength 8
-- Intelligence -4
-- Attack % 20
-- Attack Cap 160
-- Defense % 25
-- Defense Cap 75
-- Ranged ATT % 20
-- Ranged ATT Cap 160
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5603)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 8)
    target:addMod(xi.mod.INT, -4)
    target:addMod(xi.mod.FOOD_ATTP, 20)
    target:addMod(xi.mod.FOOD_ATT_CAP, 160)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 75)
    target:addMod(xi.mod.FOOD_RATTP, 20)
    target:addMod(xi.mod.FOOD_RATT_CAP, 160)
    target:addMod(xi.mod.POISONRES, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 8)
    target:delMod(xi.mod.INT, -4)
    target:delMod(xi.mod.FOOD_ATTP, 20)
    target:delMod(xi.mod.FOOD_ATT_CAP, 160)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 75)
    target:delMod(xi.mod.FOOD_RATTP, 20)
    target:delMod(xi.mod.FOOD_RATT_CAP, 160)
    target:delMod(xi.mod.POISONRES, 5)
end

return itemObject
