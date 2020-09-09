-----------------------------------------
-- ID: 5722
-- Item: plate_of_crab_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Vitality 2
-- Defense 15
-- Accuracy % 14 (cap 68)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5722)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.DEF, 15)
    target:addMod(tpz.mod.FOOD_ACCP, 14)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 68)
    target:addMod(tpz.mod.SLEEPRES, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.DEF, 15)
    target:delMod(tpz.mod.FOOD_ACCP, 14)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 68)
    target:delMod(tpz.mod.SLEEPRES, 2)
end
