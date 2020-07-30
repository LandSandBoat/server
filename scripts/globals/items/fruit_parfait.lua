-----------------------------------------
-- ID: 6063
-- Item: fruit_parfait
-- Food Effect: 180 Min, All Races
-----------------------------------------
-- MP+5% (Upper limit 50)
-- INT+3
-- MND+2
-- CHR+1
-- STR-3
-- MACC+3
-- MAB+6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 6063)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 5)
    target:addMod(tpz.mod.FOOD_MP_CAP, 50)
    target:addMod(tpz.mod.INT, 3)
    target:addMod(tpz.mod.MND, 2)
    target:addMod(tpz.mod.CHR, 1)
    target:addMod(tpz.mod.STR, -3)
    target:addMod(tpz.mod.MACC, 3)
    target:addMod(tpz.mod.MATT, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 5)
    target:delMod(tpz.mod.FOOD_MP_CAP, 50)
    target:delMod(tpz.mod.INT, 3)
    target:delMod(tpz.mod.MND, 2)
    target:delMod(tpz.mod.CHR, 1)
    target:delMod(tpz.mod.STR, -3)
    target:delMod(tpz.mod.MACC, 3)
    target:delMod(tpz.mod.MATT, 6)
end
