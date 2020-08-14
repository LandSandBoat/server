-----------------------------------------
-- ID: 4348
-- Item: mutton_enchilada
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Magic 10
-- Strength 3
-- Vitality 1
-- Intelligence -1
-- Attack % 27
-- Attack Cap 35
-- Ranged ATT % 27
-- Ranged ATT Cap 35
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4348)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 27)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 35)
    target:addMod(tpz.mod.FOOD_RATTP, 27)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 35)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 27)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 35)
    target:delMod(tpz.mod.FOOD_RATTP, 27)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 35)
end
