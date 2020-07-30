-----------------------------------------
-- ID: 5200
-- Item: dish_of_spaghetti_pescatora_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health % 15
-- Health Cap 160
-- Vitality 3
-- Mind -1
-- Defense % 22
-- Defense Cap 70
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5200)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 15)
    target:addMod(tpz.mod.FOOD_HP_CAP, 160)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.FOOD_DEFP, 22)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 70)
    target:addMod(tpz.mod.STORETP, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 15)
    target:delMod(tpz.mod.FOOD_HP_CAP, 160)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.FOOD_DEFP, 22)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 70)
    target:delMod(tpz.mod.STORETP, 6)
end
