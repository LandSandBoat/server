-----------------------------------------
-- ID: 5666
-- Item: plate_of_fin_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Intelligence 6
-- Accuracy % 17 (cap 80)
-- Ranged Accuracy % 17 (cap 80)
-- Resist Sleep +2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5666)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 6)
    target:addMod(tpz.mod.FOOD_ACCP, 17)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 80)
    target:addMod(tpz.mod.FOOD_RACCP, 17)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 80)
    target:addMod(tpz.mod.SLEEPRES, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 6)
    target:delMod(tpz.mod.FOOD_ACCP, 17)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 80)
    target:delMod(tpz.mod.FOOD_RACCP, 17)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 80)
    target:delMod(tpz.mod.SLEEPRES, 2)
end
