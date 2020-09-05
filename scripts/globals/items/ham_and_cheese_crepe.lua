-----------------------------------------
-- ID: 5771
-- Item: ham_and_cheese_crepe
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- HP +10% (cap 25)
-- STR +2
-- VIT +1
-- Magic Accuracy +10
-- Magic Defense +3
-- hHP +2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5771)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 10)
    target:addMod(tpz.mod.FOOD_HP_CAP, 25)
    target:addMod(tpz.mod.STR, 2)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.MACC, 10)
    target:addMod(tpz.mod.MDEF, 3)
    target:addMod(tpz.mod.HPHEAL, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 10)
    target:delMod(tpz.mod.FOOD_HP_CAP, 25)
    target:delMod(tpz.mod.STR, 2)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.MACC, 10)
    target:delMod(tpz.mod.MDEF, 3)
    target:delMod(tpz.mod.HPHEAL, 2)
end
