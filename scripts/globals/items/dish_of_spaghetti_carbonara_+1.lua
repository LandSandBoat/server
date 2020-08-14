-----------------------------------------
-- ID: 5199
-- Item: dish_of_spaghetti_carbonara_+1
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health % 14
-- Health Cap 180
-- Magic 15
-- Strength 4
-- Vitality 2
-- Intelligence -3
-- Attack % 17
-- Attack Cap 70
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5199)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 14)
    target:addMod(tpz.mod.FOOD_HP_CAP, 180)
    target:addMod(tpz.mod.MP, 15)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.INT, -3)
    target:addMod(tpz.mod.FOOD_ATTP, 17)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 70)
    target:addMod(tpz.mod.STORETP, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 14)
    target:delMod(tpz.mod.FOOD_HP_CAP, 180)
    target:delMod(tpz.mod.MP, 15)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.INT, -3)
    target:delMod(tpz.mod.FOOD_ATTP, 17)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 70)
    target:delMod(tpz.mod.STORETP, 6)
end
