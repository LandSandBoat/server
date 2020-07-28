-----------------------------------------
-- ID: 5669
-- Item: Bowl of Loach Slop
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- TODO: Make Group Effect
-- Accuracy 7% Cap 15
-- Ranged Accuracy 7% Cap 15
-- HP 7% Cap 15
-- Evasion 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5669)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_ACCP, 7)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 15)
    target:addMod(tpz.mod.FOOD_RACCP, 7)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 15)
    target:addMod(tpz.mod.FOOD_HPP, 7)
    target:addMod(tpz.mod.FOOD_HP_CAP, 15)
    target:addMod(tpz.mod.EVA, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_ACCP, 7)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 15)
    target:delMod(tpz.mod.FOOD_RACCP, 7)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 15)
    target:delMod(tpz.mod.FOOD_HPP, 7)
    target:delMod(tpz.mod.FOOD_HP_CAP, 15)
    target:delMod(tpz.mod.EVA, 3)
end
