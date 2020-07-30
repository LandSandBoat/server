-----------------------------------------
-- ID: 5708
-- Item: Mihgo Mithkabob
-- Food Effect: 4 Hrs, All Races
-----------------------------------------
-- Dexterity 5
-- Vitality 2
-- Mind -2
-- Accuracy +50
-- Ranged Accuracy +50
-- Evasion +5
-- Defense % 25 (cap 95)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5708)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 5)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.ACC, 50)
    target:addMod(tpz.mod.RACC, 50)
    target:addMod(tpz.mod.EVA, 5)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 95)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 5)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.ACC, 50)
    target:delMod(tpz.mod.RACC, 50)
    target:delMod(tpz.mod.EVA, 5)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 95)
end
