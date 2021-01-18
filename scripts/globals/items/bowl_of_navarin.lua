-----------------------------------
-- ID: 4439
-- Item: Bowl of Navarin
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health % 3 (cap 130)
-- Strength 3
-- Agility 1
-- Vitality 1
-- Intelligence -1
-- Attack % 27
-- Attack Cap 30
-- Evasion 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4439)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 3)
    target:addMod(tpz.mod.FOOD_HP_CAP, 130)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 27)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 30)
    target:addMod(tpz.mod.EVA, 5)
    target:addMod(tpz.mod.FOOD_RATTP, 27)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 30)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 3)
    target:delMod(tpz.mod.FOOD_HP_CAP, 130)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 27)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 30)
    target:delMod(tpz.mod.EVA, 5)
    target:delMod(tpz.mod.FOOD_RATTP, 27)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 30)
end

return item_object
