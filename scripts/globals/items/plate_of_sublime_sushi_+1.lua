-----------------------------------------
-- ID: 6469
-- Item: plate_of_sublime_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- HP +45
-- MP +25
-- STR +7
-- DEX +8
-- MND -4
-- CHR +7
-- Accuracy +11% (cap 105)
-- Ranged Accuracy +11% (cap 105)
-- Resist Sleep +2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 6469)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 45)
    target:addMod(tpz.mod.MP, 25)
    target:addMod(tpz.mod.STR, 7)
    target:addMod(tpz.mod.DEX, 8)
    target:addMod(tpz.mod.MND, -4)
    target:addMod(tpz.mod.CHR, 7)
    target:addMod(tpz.mod.FOOD_ACCP, 11)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 105)
    target:addMod(tpz.mod.FOOD_RACCP, 11)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 105)
    target:addMod(tpz.mod.SLEEPRES, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 45)
    target:delMod(tpz.mod.MP, 25)
    target:delMod(tpz.mod.STR, 7)
    target:delMod(tpz.mod.DEX, 8)
    target:delMod(tpz.mod.MND, -4)
    target:delMod(tpz.mod.CHR, 7)
    target:delMod(tpz.mod.FOOD_ACCP, 11)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 105)
    target:delMod(tpz.mod.FOOD_RACCP, 11)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 105)
    target:delMod(tpz.mod.SLEEPRES, 2)
end
