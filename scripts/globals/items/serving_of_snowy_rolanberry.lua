-----------------------------------------
-- ID: 4594
-- Item: serving_of_snowy_rolanberry
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Magic % 19
-- Magic Cap 60
-- Intelligence 2
-- Wind Res 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4594)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 19)
    target:addMod(tpz.mod.FOOD_MP_CAP, 60)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.WINDRES, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 19)
    target:delMod(tpz.mod.FOOD_MP_CAP, 60)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.WINDRES, 5)
end
