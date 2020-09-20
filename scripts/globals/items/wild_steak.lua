-----------------------------------------
-- ID: 4519
-- Item: wild_steak
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Strength 4
-- Intelligence -2
-- Attack % 25
-- Attack Cap 50
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4519)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 25)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 50)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 25)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 50)
end
