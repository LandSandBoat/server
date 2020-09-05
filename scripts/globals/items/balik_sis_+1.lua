-----------------------------------------
-- ID: 5601
-- Item: Balik Sis +1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Dexterity 5
-- Mind -2
-- Attack % 15
-- Attack Cap 70
-- Ranged ACC 2
-- Ranged ATT % 15
-- Ranged ATT Cap 70
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5601)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 5)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 15)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 70)
    target:addMod(tpz.mod.RACC, 2)
    target:addMod(tpz.mod.FOOD_RATTP, 15)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 70)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 5)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 15)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 70)
    target:delMod(tpz.mod.RACC, 2)
    target:delMod(tpz.mod.FOOD_RATTP, 15)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 70)
end
