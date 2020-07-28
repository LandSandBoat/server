-----------------------------------------
-- ID: 5750
-- Item: bowl_of_goulash
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- VIT +3
-- INT -2
-- Accuracy +10% (cap 54)
-- DEF +10% (cap 30)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5750)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.FOOD_ACCP, 10)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 54)
    target:addMod(tpz.mod.FOOD_DEFP, 10)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 30)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.FOOD_ACCP, 10)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 54)
    target:delMod(tpz.mod.FOOD_DEFP, 10)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 30)
end
