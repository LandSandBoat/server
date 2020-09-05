-----------------------------------------
-- ID: 5599
-- Item: sis_kebabi_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Strength 6
-- Vitality -1
-- Intelligence -1
-- Attack % 22
-- Attack Cap 75
-- Ranged ATT % 22
-- Ranged ATT Cap 75
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5599)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 22)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 75)
    target:addMod(tpz.mod.FOOD_RATTP, 22)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 75)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 22)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 75)
    target:delMod(tpz.mod.FOOD_RATTP, 22)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 75)
end
