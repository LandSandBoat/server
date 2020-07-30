-----------------------------------------
-- ID: 5719
-- Item: dish_of_spaghetti_marinara
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP % 15 (cap 120)
-- Vitality 2
-- Defense 5
-- Store TP 6
-- hHP +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5719)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 15)
    target:addMod(tpz.mod.FOOD_HP_CAP, 120)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.DEF, 5)
    target:addMod(tpz.mod.STORETP, 6)
    target:addMod(tpz.mod.HPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 15)
    target:delMod(tpz.mod.FOOD_HP_CAP, 120)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.DEF, 5)
    target:delMod(tpz.mod.STORETP, 6)
    target:delMod(tpz.mod.HPHEAL, 1)
end
