-----------------------------------------
-- ID: 6468
-- Item: plate_of_sublime_sushi
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP +40
-- MP +20
-- STR +6
-- DEX +7
-- MND -3
-- CHR +6
-- Accuracy +10% (cap 100)
-- Ranged Accuracy +10% (cap 100)
-- Resist Sleep +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6468)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 40)
    target:addMod(tpz.mod.MP, 20)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.DEX, 7)
    target:addMod(tpz.mod.MND, -3)
    target:addMod(tpz.mod.CHR, 6)
    target:addMod(tpz.mod.FOOD_ACCP, 10)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 100)
    target:addMod(tpz.mod.FOOD_RACCP, 10)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 100)
    target:addMod(tpz.mod.SLEEPRES, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 40)
    target:delMod(tpz.mod.MP, 20)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.DEX, 7)
    target:delMod(tpz.mod.MND, -3)
    target:delMod(tpz.mod.CHR, 6)
    target:delMod(tpz.mod.FOOD_ACCP, 10)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 100)
    target:delMod(tpz.mod.FOOD_RACCP, 10)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 100)
    target:delMod(tpz.mod.SLEEPRES, 1)
end
