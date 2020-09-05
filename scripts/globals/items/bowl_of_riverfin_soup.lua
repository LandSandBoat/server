-----------------------------------------
-- ID: 6069
-- Item: Bowl of Riverfin Soup
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- Accuracy % 14 Cap 90
-- Ranged Accuracy % 14 Cap 90
-- Attack % 18 Cap 80
-- Ranged Attack % 18 Cap 80
-- Amorph Killer 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 6069)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_ACCP, 14)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 90)
    target:addMod(tpz.mod.FOOD_RACCP, 14)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 90)
    target:addMod(tpz.mod.FOOD_ATTP, 18)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:addMod(tpz.mod.FOOD_RATTP, 18)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 80)
    target:addMod(tpz.mod.AMORPH_KILLER, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_ACCP, 14)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 90)
    target:delMod(tpz.mod.FOOD_RACCP, 14)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 90)
    target:delMod(tpz.mod.FOOD_ATTP, 18)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:delMod(tpz.mod.FOOD_RATTP, 18)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 80)
    target:delMod(tpz.mod.AMORPH_KILLER, 5)
end
