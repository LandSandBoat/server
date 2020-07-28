-----------------------------------------
-- ID: 6064
-- Item: queens_crown
-- Food Effect: 240 Min, All Races
-----------------------------------------
-- MP+6% (Upper limit 55)
-- INT+4
-- MND+3
-- CHR+2
-- STR-2
-- MACC+4
-- MAB+7
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 6064)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 6)
    target:addMod(tpz.mod.FOOD_MP_CAP, 55)
    target:addMod(tpz.mod.INT, 4)
    target:addMod(tpz.mod.MND, 3)
    target:addMod(tpz.mod.CHR, 2)
    target:addMod(tpz.mod.STR, -2)
    target:addMod(tpz.mod.MACC, 4)
    target:addMod(tpz.mod.MATT, 7)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 6)
    target:delMod(tpz.mod.FOOD_MP_CAP, 55)
    target:delMod(tpz.mod.INT, 4)
    target:delMod(tpz.mod.MND, 3)
    target:delMod(tpz.mod.CHR, 2)
    target:delMod(tpz.mod.STR, -2)
    target:delMod(tpz.mod.MACC, 4)
    target:delMod(tpz.mod.MATT, 7)
end
