-----------------------------------------
-- ID: 5238
-- Item: Seafood Stewpot
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- TODO: Group Effect
-- HP +10% Cap 50
-- MP +10
-- Accuracy 5
-- Ranged Accuracy 5
-- Evasion 5
-- hHP 5
-- hMP 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5238)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 10)
    target:addMod(tpz.mod.FOOD_HP_CAP, 50)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.ACC, 5)
    target:addMod(tpz.mod.RACC, 5)
    target:addMod(tpz.mod.EVA, 5)
    target:addMod(tpz.mod.HPHEAL, 5)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 10)
    target:delMod(tpz.mod.FOOD_HP_CAP, 50)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.ACC, 5)
    target:delMod(tpz.mod.RACC, 5)
    target:delMod(tpz.mod.EVA, 5)
    target:delMod(tpz.mod.HPHEAL, 5)
    target:delMod(tpz.mod.MPHEAL, 1)
end
