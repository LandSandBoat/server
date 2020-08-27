-----------------------------------------
-- ID: 5219
-- Item: plate_of_ikra_gunkan
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 30
-- Magic 10
-- Dexterity 3
-- Mind -2
-- Accuracy % 18
-- Accuracy Cap 28
-- Ranged ACC % 18
-- Ranged ACC Cap 28
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5219)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.FOOD_ACCP, 18)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 28)
    target:addMod(tpz.mod.FOOD_RACCP, 18)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 28)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.FOOD_ACCP, 18)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 28)
    target:delMod(tpz.mod.FOOD_RACCP, 18)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 28)
end
