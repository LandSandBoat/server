-----------------------------------------
-- ID: 5775
-- Item: Chocolate Crepe
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- HP +5% (cap 15)
-- MP Healing 2
-- Magic Accuracy +20% (cap 35)
-- Magic Defense +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5775)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 5)
    target:addMod(tpz.mod.FOOD_HP_CAP, 15)
    target:addMod(tpz.mod.MPHEAL, 2)
    target:addMod(tpz.mod.MDEF, 1)
    target:addMod(tpz.mod.FOOD_MACCP, 20)
    target:addMod(tpz.mod.FOOD_MACC_CAP, 35)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 5)
    target:delMod(tpz.mod.FOOD_HP_CAP, 15)
    target:delMod(tpz.mod.MPHEAL, 2)
    target:delMod(tpz.mod.MDEF, 1)
    target:delMod(tpz.mod.FOOD_MACCP, 20)
    target:delMod(tpz.mod.FOOD_MACC_CAP, 35)
end
