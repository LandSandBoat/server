-----------------------------------------
-- ID: 4322
-- Item: dhalmel_pie_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 25
-- Strength 4
-- Agility 2
-- Vitality 1
-- Intelligence -2
-- Mind 1
-- Attack % 25
-- Attack Cap 50
-- Ranged ATT % 25
-- Ranged ATT Cap 50
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4322)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 25)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.MND, 1)
    target:addMod(tpz.mod.FOOD_ATTP, 25)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 50)
    target:addMod(tpz.mod.FOOD_RATTP, 25)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 50)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 25)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.MND, 1)
    target:delMod(tpz.mod.FOOD_ATTP, 25)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 50)
    target:delMod(tpz.mod.FOOD_RATTP, 25)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 50)
end
