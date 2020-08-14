-----------------------------------------
-- ID: 5776
-- Item: Crepe Caprice
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- HP +5% (cap20)
-- MP Healing 3
-- Magic Accuracy +21% (cap 40)
-- Magic Defense +2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5776)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 5)
    target:addMod(tpz.mod.FOOD_HP_CAP, 20)
    target:addMod(tpz.mod.MPHEAL, 3)
    target:addMod(tpz.mod.MDEF, 2)
    target:addMod(tpz.mod.FOOD_MACCP, 21)
    target:addMod(tpz.mod.FOOD_MACC_CAP, 40)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 5)
    target:delMod(tpz.mod.FOOD_HP_CAP, 20)
    target:delMod(tpz.mod.MPHEAL, 3)
    target:delMod(tpz.mod.MDEF, 2)
    target:delMod(tpz.mod.FOOD_MACCP, 21)
    target:delMod(tpz.mod.FOOD_MACC_CAP, 40)
end
