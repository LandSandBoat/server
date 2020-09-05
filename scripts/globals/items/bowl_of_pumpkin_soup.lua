-----------------------------------------
-- ID: 4430
-- Item: bowl_of_pumpkin_soup
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- HP % 1 (cap 110)
-- Vitality -1
-- Agility 3
-- HP Recovered While Healing 5
-- Ranged Accuracy % 8 (cap 20)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4430)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 1)
    target:addMod(tpz.mod.FOOD_HP_CAP, 110)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.HPHEAL, 5)
    target:addMod(tpz.mod.FOOD_RACCP, 8)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 1)
    target:delMod(tpz.mod.FOOD_HP_CAP, 110)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.HPHEAL, 5)
    target:delMod(tpz.mod.FOOD_RACCP, 8)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 20)
end
