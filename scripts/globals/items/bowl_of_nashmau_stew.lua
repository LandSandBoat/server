-----------------------------------------
-- ID: 5595
-- Item: Bowl of Nashmau Stew
-- Food Effect: 4 Hrs, All Races
-----------------------------------------
-- TODO: Group Effect
-- MP -100
-- Vitality -10
-- Agility -10
-- Intelligence -10
-- Mind -10
-- Charisma -10
-- Accuracy +15% Cap 25
-- Attack +18% Cap 60
-- Defense -100
-- Evasion -100
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5595)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, -100)
    target:addMod(tpz.mod.VIT, -10)
    target:addMod(tpz.mod.AGI, -10)
    target:addMod(tpz.mod.INT, -10)
    target:addMod(tpz.mod.MND, -10)
    target:addMod(tpz.mod.CHR, -10)
    target:addMod(tpz.mod.FOOD_ACCP, 15)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 25)
    target:addMod(tpz.mod.FOOD_ATTP, 18)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 60)
    target:addMod(tpz.mod.DEF, -100)
    target:addMod(tpz.mod.EVA, -100)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, -100)
    target:delMod(tpz.mod.VIT, -10)
    target:delMod(tpz.mod.AGI, -10)
    target:delMod(tpz.mod.INT, -10)
    target:delMod(tpz.mod.MND, -10)
    target:delMod(tpz.mod.CHR, -10)
    target:delMod(tpz.mod.FOOD_ACCP, 15)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 25)
    target:delMod(tpz.mod.FOOD_ATTP, 18)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 60)
    target:delMod(tpz.mod.DEF, -100)
    target:delMod(tpz.mod.EVA, -100)
end
