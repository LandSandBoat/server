-----------------------------------------
-- ID: 5721
-- Item: plate_of_crab_sushi
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Vitality 1
-- Defense 10
-- Accuracy % 13 (cap 64)
-- Resist Sleep +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5721)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.DEF, 10)
    target:addMod(tpz.mod.FOOD_ACCP, 13)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 64)
    target:addMod(tpz.mod.SLEEPRES, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.DEF, 10)
    target:delMod(tpz.mod.FOOD_ACCP, 13)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 64)
    target:delMod(tpz.mod.SLEEPRES, 1)
end
