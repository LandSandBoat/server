-----------------------------------------
-- ID: 6225
-- Item: Cyclical coalescence
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- MP +30% (cap 110)
-- INT +7
-- MND +7
-- Magic Atk. Bonus +15
-- Lizard Killer +7
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6225)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 30)
    target:addMod(tpz.mod.FOOD_MP_CAP, 110)
    target:addMod(tpz.mod.INT, 7)
    target:addMod(tpz.mod.MND, 7)
    target:addMod(tpz.mod.MATT, 15)
    target:addMod(tpz.mod.LIZARD_KILLER, 7)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 30)
    target:delMod(tpz.mod.FOOD_MP_CAP, 110)
    target:delMod(tpz.mod.INT, 7)
    target:delMod(tpz.mod.MND, 7)
    target:delMod(tpz.mod.MATT, 15)
    target:delMod(tpz.mod.LIZARD_KILLER, 7)
end
