-----------------------------------
-- ID: 4506
-- Item: mutton_tortilla
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 10
-- Strength 3
-- Vitality 1
-- Intelligence -1
-- Attack % 27
-- Attack Cap 30
-- Ranged ATT % 27
-- Ranged ATT Cap 30
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4506)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 27)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 30)
    target:addMod(tpz.mod.FOOD_RATTP, 27)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 30)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 27)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 30)
    target:delMod(tpz.mod.FOOD_RATTP, 27)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 30)
end

return item_object
