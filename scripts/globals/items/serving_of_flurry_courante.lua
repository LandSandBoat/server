-----------------------------------------
-- ID: 5555
-- Item: serving_of_flurry_courante
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Magic % 19
-- Magic Cap 65
-- Intelligence 2
-- Magic Regen While Healing 1
-- Wind Resist 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5555)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 19)
    target:addMod(tpz.mod.FOOD_MP_CAP, 65)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.MPHEAL, 1)
    target:addMod(tpz.mod.WINDRES, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 19)
    target:delMod(tpz.mod.FOOD_MP_CAP, 65)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.MPHEAL, 1)
    target:delMod(tpz.mod.WINDRES, 5)
end
