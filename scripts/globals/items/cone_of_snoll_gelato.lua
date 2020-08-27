-----------------------------------------
-- ID: 5147
-- Item: cone_of_snoll_gelato
-- Food Effect: 30Min, All Races
-----------------------------------------
-- MP % 16 (cap 75)
-- MP Recovered While Healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5147)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 16)
    target:addMod(tpz.mod.FOOD_MP_CAP, 75)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 16)
    target:delMod(tpz.mod.FOOD_MP_CAP, 75)
    target:delMod(tpz.mod.MPHEAL, 1)
end
