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
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5603)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 8)
    target:addMod(tpz.mod.INT, -4)
    target:addMod(tpz.mod.FOOD_ATTP, 20)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 160)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 75)
    target:addMod(tpz.mod.FOOD_RATTP, 20)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 160)
    target:addMod(tpz.mod.POISONRES, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 8)
    target:delMod(tpz.mod.INT, -4)
    target:delMod(tpz.mod.FOOD_ATTP, 20)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 160)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 75)
    target:delMod(tpz.mod.FOOD_RATTP, 20)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 160)
    target:delMod(tpz.mod.POISONRES, 5)
end

return item_object
