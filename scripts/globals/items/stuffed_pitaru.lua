-----------------------------------------
-- ID: 5889
-- Item: stuffed_pitaru
-- Food Effect: 30Min, All Races
-----------------------------------------
-- MP +6% (cap 100)
-- Increases rate of magic skill gains by 20%
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5889)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 6)
    target:addMod(tpz.mod.FOOD_MP_CAP, 100)
    target:addMod(tpz.mod.MAGIC_SKILLUP_RATE, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 6)
    target:delMod(tpz.mod.FOOD_MP_CAP, 100)
    target:delMod(tpz.mod.MAGIC_SKILLUP_RATE, 20)
end
