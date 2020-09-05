-----------------------------------------
-- ID: 5189
-- Item: dish_of_spaghetti_vongole_rosso
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health % 20
-- Health Cap 90
-- Vitality 2
-- Mind -1
-- Defense % 25
-- Defense Cap 30
-- Store TP 6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5189)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 20)
    target:addMod(tpz.mod.FOOD_HP_CAP, 90)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 30)
    target:addMod(tpz.mod.STORETP, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 20)
    target:delMod(tpz.mod.FOOD_HP_CAP, 90)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 30)
    target:delMod(tpz.mod.STORETP, 6)
end
