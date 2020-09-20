-----------------------------------------
-- ID: 5600
-- Item: Balik Sis
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Dexterity 4
-- Mind -2
-- Attack % 13
-- Attack Cap 65
-- Ranged ACC 1
-- Ranged ATT % 13
-- Ranged ATT Cap 65
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5600)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 13)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 65)
    target:addMod(tpz.mod.RACC, 1)
    target:addMod(tpz.mod.FOOD_RATTP, 13)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 65)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 13)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 65)
    target:delMod(tpz.mod.RACC, 1)
    target:delMod(tpz.mod.FOOD_RATTP, 13)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 65)
end
