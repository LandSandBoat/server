-----------------------------------------
-- ID: 5188
-- Item: dish_of_spaghetti_peperoncino
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health % 30
-- Health Cap 70
-- Vitality 2
-- Store TP +6
-- Resist virus +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5188)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 30)
    target:addMod(tpz.mod.FOOD_HP_CAP, 70)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.STORETP, 6)
    target:addMod(tpz.mod.VIRUSRES, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 30)
    target:delMod(tpz.mod.FOOD_HP_CAP, 70)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.STORETP, 6)
    target:delMod(tpz.mod.VIRUSRES, 10)
end
