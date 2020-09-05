-----------------------------------------
-- ID: 4297
-- Item: serving_of_black_curry
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Dexterity 2
-- Vitality 4
-- Intelligence 1
-- Health Regen While Healing 2
-- Magic Regen While Healing 1
-- defense % 15 (cap 180)
-- Accuracy 5
-- Evasion 5
-- Ranged ACC 5
-- Sleep Resist 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4297)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 1)
    target:addMod(tpz.mod.FOOD_DEFP, 15)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 180)
    target:addMod(tpz.mod.ACC, 5)
    target:addMod(tpz.mod.EVA, 5)
    target:addMod(tpz.mod.RACC, 5)
    target:addMod(tpz.mod.SLEEPRES, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 1)
    target:delMod(tpz.mod.FOOD_DEFP, 15)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 180)
    target:delMod(tpz.mod.ACC, 5)
    target:delMod(tpz.mod.EVA, 5)
    target:delMod(tpz.mod.RACC, 5)
    target:delMod(tpz.mod.SLEEPRES, 3)
end
