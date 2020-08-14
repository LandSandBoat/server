-----------------------------------------
-- ID: 5178
-- Item: plate_of_dorado_sushi
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Dexterity 5
-- Accuracy % 15
-- Accuracy Cap 72
-- Ranged ACC % 15
-- Ranged ACC Cap 72
-- Sleep Resist 1
-- Enmity 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5178)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ENMITY, 4)
    target:addMod(tpz.mod.DEX, 5)
    target:addMod(tpz.mod.FOOD_ACCP, 15)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 72)
    target:addMod(tpz.mod.FOOD_RACCP, 15)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 72)
    target:addMod(tpz.mod.SLEEPRES, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ENMITY, 4)
    target:delMod(tpz.mod.DEX, 5)
    target:delMod(tpz.mod.FOOD_ACCP, 15)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 72)
    target:delMod(tpz.mod.FOOD_RACCP, 15)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 72)
    target:delMod(tpz.mod.SLEEPRES, 1)
end
