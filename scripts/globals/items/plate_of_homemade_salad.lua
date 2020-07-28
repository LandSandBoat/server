-----------------------------------------
-- ID: 5227
-- Item: plate_of_homemade_salad
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Magic 10
-- Accuracy +12% (cap 80)
-- Attack +10% (cap 40)
-- Ranged Accuracy +12% (cap 80)
-- Ranged Attack +10% (cap 40)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5227)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.FOOD_ACCP, 12)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 80)
    target:addMod(tpz.mod.FOOD_ATTP, 10)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 40)
    target:addMod(tpz.mod.FOOD_RACCP, 12)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 80)
    target:addMod(tpz.mod.FOOD_RATTP, 10)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 40)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.FOOD_ACCP, 12)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 80)
    target:delMod(tpz.mod.FOOD_ATTP, 10)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 40)
    target:delMod(tpz.mod.FOOD_RACCP, 12)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 80)
    target:delMod(tpz.mod.FOOD_RATTP, 10)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 40)
end
