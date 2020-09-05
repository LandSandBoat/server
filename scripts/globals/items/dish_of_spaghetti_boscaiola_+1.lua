-----------------------------------------
-- ID: 5201
-- Item: dish_of_spaghetti_boscaiola_+1
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health % 18
-- Health Cap 130
-- Magic 40
-- Strength -5
-- Dexterity -2
-- Vitality 2
-- Mind 4
-- Store TP +6
-- Magic Regen While Healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5201)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 18)
    target:addMod(tpz.mod.FOOD_HP_CAP, 130)
    target:addMod(tpz.mod.MP, 40)
    target:addMod(tpz.mod.STR, -5)
    target:addMod(tpz.mod.DEX, -2)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.MND, 4)
    target:addMod(tpz.mod.STORETP, 6)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 18)
    target:delMod(tpz.mod.FOOD_HP_CAP, 130)
    target:delMod(tpz.mod.MP, 40)
    target:delMod(tpz.mod.STR, -5)
    target:delMod(tpz.mod.DEX, -2)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.MND, 4)
    target:delMod(tpz.mod.STORETP, 6)
    target:delMod(tpz.mod.MPHEAL, 1)
end
