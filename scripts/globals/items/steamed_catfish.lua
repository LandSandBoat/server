-----------------------------------------
-- ID: 4557
-- Item: steamed_catfish
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Health 30
-- Magic % 1 (cap 110)
-- Dex 3
-- Intelligence 1
-- Mind -3
-- Earth Res 10
-- Ranged Accuracy +6% (cap 15)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4557)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.FOOD_MPP, 1)
    target:addMod(tpz.mod.FOOD_MP_CAP, 110)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.MND, -3)
    target:addMod(tpz.mod.EARTHRES, 10)
    target:addMod(tpz.mod.FOOD_RACCP, 6)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 15)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.FOOD_MPP, 1)
    target:delMod(tpz.mod.FOOD_MP_CAP, 110)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.MND, -3)
    target:delMod(tpz.mod.EARTHRES, 10)
    target:delMod(tpz.mod.FOOD_RACCP, 6)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 15)
end
