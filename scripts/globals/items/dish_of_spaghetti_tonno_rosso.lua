-----------------------------------------
-- ID: 5623
-- Item: Dish of Spaghetti Tonno Rosso
-- Food Effect: 30 Mins, All Races
-----------------------------------------
-- Health % 13
-- Health Cap 180
-- Dexterity 1
-- Vitality 2
-- Store TP +6
-- hMP +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5623)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 13)
    target:addMod(tpz.mod.FOOD_HP_CAP, 180)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.STORETP, 6)
    target:addMod(tpz.mod.HPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 13)
    target:delMod(tpz.mod.FOOD_HP_CAP, 180)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.STORETP, 6)
    target:delMod(tpz.mod.HPHEAL, 1)
end
