-----------------------------------------
-- ID: 4578
-- Item: sausage
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health % 3 (cap 130)
-- Strength 3
-- Intelligence -1
-- Attack % 27
-- Attack Cap 30
-- Ranged ATT % 27
-- Ranged ATT Cap 30
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4578)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 3)
    target:addMod(tpz.mod.FOOD_HP_CAP, 130)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 27)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 30)
    target:addMod(tpz.mod.FOOD_RATTP, 27)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 30)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 3)
    target:delMod(tpz.mod.FOOD_HP_CAP, 130)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 27)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 30)
    target:delMod(tpz.mod.FOOD_RATTP, 27)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 30)
end
