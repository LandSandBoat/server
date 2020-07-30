-----------------------------------------
-- ID: 4490
-- Item: Pickled Herring
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Dexterity 3
-- Mind -3
-- Attack % 12 (cap 70)
-- Ranged ATT % 12 (cap 70)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4490)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.MND, -3)
    target:addMod(tpz.mod.FOOD_ATTP, 12)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 70)
    target:addMod(tpz.mod.FOOD_RATTP, 12)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 70)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.MND, -3)
    target:delMod(tpz.mod.FOOD_ATTP, 12)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 70)
    target:delMod(tpz.mod.FOOD_RATTP, 12)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 70)
end
