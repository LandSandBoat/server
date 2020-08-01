-----------------------------------------
-- ID: 5891
-- Item: seafood_pitaru
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- MP +8% (cap 120)
-- Increases rate of magic skill gains by 60%
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5891)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 8)
    target:addMod(tpz.mod.FOOD_MP_CAP, 120)
    target:addMod(tpz.mod.MAGIC_SKILLUP_RATE, 60)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 8)
    target:delMod(tpz.mod.FOOD_MP_CAP, 120)
    target:delMod(tpz.mod.MAGIC_SKILLUP_RATE, 60)
end
