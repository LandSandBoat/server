-----------------------------------------
-- ID: 6072
-- Item: Magma Steak +1
-- Food Effect: 240 Min, All Races
-----------------------------------------
-- Strength +9
-- Attack +24% Cap 185
-- Ranged Attack +24% Cap 185
-- Vermin Killer +6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 6072)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 9)
    target:addMod(tpz.mod.FOOD_ATTP, 24)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 185)
    target:addMod(tpz.mod.FOOD_RATTP, 24)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 185)
    target:addMod(tpz.mod.VERMIN_KILLER, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 9)
    target:delMod(tpz.mod.FOOD_ATTP, 24)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 185)
    target:delMod(tpz.mod.FOOD_RATTP, 24)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 185)
    target:delMod(tpz.mod.VERMIN_KILLER, 6)
end
