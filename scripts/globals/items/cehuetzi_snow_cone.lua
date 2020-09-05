-----------------------------------------
-- ID: 6223
-- Item: Cehuetzi snow cone
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- MP +20% (cap 100)
-- INT +5
-- MND +5
-- Magic Atk. Bonus +13
-- Lizard Killer +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6223)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 20)
    target:addMod(tpz.mod.FOOD_MP_CAP, 100)
    target:addMod(tpz.mod.INT, 5)
    target:addMod(tpz.mod.MND, 5)
    target:addMod(tpz.mod.MATT, 13)
    target:addMod(tpz.mod.LIZARD_KILLER, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 20)
    target:delMod(tpz.mod.FOOD_MP_CAP, 100)
    target:delMod(tpz.mod.INT, 5)
    target:delMod(tpz.mod.MND, 5)
    target:delMod(tpz.mod.MATT, 13)
    target:delMod(tpz.mod.LIZARD_KILLER, 5)
end
