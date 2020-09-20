-----------------------------------------
-- ID: 5142
-- Item: serving_of_bison_steak
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Strength 6
-- Agility 1
-- Intelligence -3
-- Attack % 18
-- Attack Cap 90
-- Ranged ATT % 18
-- Ranged ATT Cap 90
-- Lizard Killer 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5142)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.INT, -3)
    target:addMod(tpz.mod.FOOD_ATTP, 18)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 90)
    target:addMod(tpz.mod.FOOD_RATTP, 18)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 90)
    target:addMod(tpz.mod.LIZARD_KILLER, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.INT, -3)
    target:delMod(tpz.mod.FOOD_ATTP, 18)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 90)
    target:delMod(tpz.mod.FOOD_RATTP, 18)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 90)
    target:delMod(tpz.mod.LIZARD_KILLER, 5)
end
