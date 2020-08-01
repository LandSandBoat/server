-----------------------------------------
-- ID: 4393
-- Item: orange_kuchen
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Magic % 13
-- Magic Cap 75
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4393)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 13)
    target:addMod(tpz.mod.FOOD_MP_CAP, 75)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 13)
    target:delMod(tpz.mod.FOOD_MP_CAP, 75)
end
