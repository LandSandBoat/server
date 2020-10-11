-----------------------------------------
-- ID: 4395
-- Item: galkan_sausage
-- Food Effect: 30Min, All Races
-----------------------------------------
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4395)
end

function onEffectGain(target, effect)
    if (target:getRace() ~= tpz.race.GALKA) then
        target:addMod(tpz.mod.STR, 3)
        target:addMod(tpz.mod.INT, -4)
        target:addMod(tpz.mod.ATT, 9)
        target:addMod(tpz.mod.RATT, 9)
    else
        target:addMod(tpz.mod.STR, 3)
        target:addMod(tpz.mod.INT, -1)
        target:addMod(tpz.mod.FOOD_ATTP, 25)
        target:addMod(tpz.mod.FOOD_ATT_CAP, 30)
        target:addMod(tpz.mod.FOOD_RATTP, 25)
        target:addMod(tpz.mod.FOOD_RATT_CAP, 30)
    end
end

function onEffectLose(target, effect)
    if (target:getRace() ~= tpz.race.GALKA) then
        target:delMod(tpz.mod.STR, 3)
        target:delMod(tpz.mod.INT, -4)
        target:delMod(tpz.mod.ATT, 9)
        target:delMod(tpz.mod.RATT, 9)
    else
        target:delMod(tpz.mod.STR, 3)
        target:delMod(tpz.mod.INT, -1)
        target:delMod(tpz.mod.FOOD_ATTP, 25)
        target:delMod(tpz.mod.FOOD_ATT_CAP, 30)
        target:delMod(tpz.mod.FOOD_RATTP, 25)
        target:delMod(tpz.mod.FOOD_RATT_CAP, 30)
    end
end
