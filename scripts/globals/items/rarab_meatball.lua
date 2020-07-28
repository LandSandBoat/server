-----------------------------------------
-- ID: 4507
-- Item: rarab_meatball
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Health 10
-- Strength 2
-- Vitality 2
-- Intelligence -1
-- Attack % 30
-- Attack Cap 20
-- Ranged ATT % 30
-- Ranged ATT Cap 20
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4507)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.STR, 2)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 30)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 20)
    target:addMod(tpz.mod.FOOD_RATTP, 30)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.STR, 2)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 30)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 20)
    target:delMod(tpz.mod.FOOD_RATTP, 30)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 20)
end
