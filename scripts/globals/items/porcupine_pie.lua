-----------------------------------------
-- ID: 5156
-- Item: porcupine_pie
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP 55
-- Strength 6
-- Vitality 2
-- Intelligence -3
-- Mind 3
-- HP recovered while healing 2
-- MP recovered while healing 2
-- Accuracy 5
-- Attack % 18 (cap 95)
-- Ranged Attack % 18 (cap 95)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5156)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 55)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.INT, -3)
    target:addMod(tpz.mod.MND, 3)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 2)
    target:addMod(tpz.mod.ACC, 5)
    target:addMod(tpz.mod.FOOD_ATTP, 18)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 95)
    target:addMod(tpz.mod.FOOD_RATTP, 18)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 95)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 55)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.INT, -3)
    target:delMod(tpz.mod.MND, 3)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 2)
    target:delMod(tpz.mod.ACC, 5)
    target:delMod(tpz.mod.FOOD_ATTP, 18)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 95)
    target:delMod(tpz.mod.FOOD_RATTP, 18)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 95)
end
