-----------------------------------------
-- ID: 5196
-- Item: strip_of_buffalo_jerky
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Strength 4
-- Mind -2
-- Attack % 18
-- Attack Cap 65
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5196)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 18)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 65)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 18)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 65)
end
