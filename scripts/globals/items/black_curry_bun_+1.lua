-----------------------------------------
-- ID: 5764
-- Item: black_curry_bun+1
-- Food Effect: 60 min, All Races
-----------------------------------------
-- TODO: Group effects
-- Dexterity +4
-- Vitality +6
-- Intelligence +3
-- Mind +1
-- Accuracy +7
-- Ranged Accuracy +7
-- Evasion +7
-- Defense +25% (cap 200)
-- Resist Sleep +5
-- hHP +6
-- hMP +3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5764)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 4)
    target:addMod(tpz.mod.VIT, 6)
    target:addMod(tpz.mod.INT, 3)
    target:addMod(tpz.mod.MND, 1)
    target:addMod(tpz.mod.ACC, 7)
    target:addMod(tpz.mod.RACC, 7)
    target:addMod(tpz.mod.EVA, 7)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 200)
    target:addMod(tpz.mod.SLEEPRES, 5)
    target:addMod(tpz.mod.HPHEAL, 6)
    target:addMod(tpz.mod.MPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 4)
    target:delMod(tpz.mod.VIT, 6)
    target:delMod(tpz.mod.INT, 3)
    target:delMod(tpz.mod.MND, 1)
    target:delMod(tpz.mod.ACC, 7)
    target:delMod(tpz.mod.RACC, 7)
    target:delMod(tpz.mod.EVA, 7)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 200)
    target:delMod(tpz.mod.SLEEPRES, 5)
    target:delMod(tpz.mod.HPHEAL, 6)
    target:delMod(tpz.mod.MPHEAL, 3)
end
