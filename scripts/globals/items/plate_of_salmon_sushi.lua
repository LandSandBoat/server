-----------------------------------------
-- ID: 5663
-- Item: plate_of_salmon_sushi
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Strength 1
-- Accuracy % 14 (cap 68)
-- Ranged ACC % 14 (cap 68)
-- Resist sleep +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5663)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 1)
    target:addMod(tpz.mod.FOOD_ACCP, 14)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 68)
    target:addMod(tpz.mod.FOOD_RACCP, 14)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 68)
    target:addMod(tpz.mod.SLEEPRES, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 1)
    target:delMod(tpz.mod.FOOD_ACCP, 14)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 68)
    target:delMod(tpz.mod.FOOD_RACCP, 14)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 68)
    target:delMod(tpz.mod.SLEEPRES, 1)
end
