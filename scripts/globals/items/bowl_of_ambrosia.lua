-----------------------------------------
-- ID: 4511
-- Item: Bowl of Ambrosia
-- Food Effect: 240Min, All Races
-----------------------------------------
-- HP +7
-- MP +7
-- STR +7
-- DEX +7
-- VIT +7
-- AGI +7
-- INT +7
-- MND +7
-- CHR +7
-- Accuracy +7
-- Ranged Accuracy +7
-- Attack +7
-- Ranged Attack +7
-- Evasion +7
-- Defense +7
-- HP recovered while healing +7
-- MP recovered while healing +7
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4511)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 7)
    target:addMod(tpz.mod.MP, 7)
    target:addMod(tpz.mod.STR, 7)
    target:addMod(tpz.mod.DEX, 7)
    target:addMod(tpz.mod.VIT, 7)
    target:addMod(tpz.mod.AGI, 7)
    target:addMod(tpz.mod.INT, 7)
    target:addMod(tpz.mod.MND, 7)
    target:addMod(tpz.mod.CHR, 7)
    target:addMod(tpz.mod.ATT, 7)
    target:addMod(tpz.mod.RATT, 7)
    target:addMod(tpz.mod.ACC, 7)
    target:addMod(tpz.mod.RACC, 7)
    target:addMod(tpz.mod.HPHEAL, 7)
    target:addMod(tpz.mod.MPHEAL, 7)
    target:addMod(tpz.mod.DEF, 7)
    target:addMod(tpz.mod.EVA, 7)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 7)
    target:delMod(tpz.mod.MP, 7)
    target:delMod(tpz.mod.STR, 7)
    target:delMod(tpz.mod.DEX, 7)
    target:delMod(tpz.mod.VIT, 7)
    target:delMod(tpz.mod.AGI, 7)
    target:delMod(tpz.mod.INT, 7)
    target:delMod(tpz.mod.MND, 7)
    target:delMod(tpz.mod.CHR, 7)
    target:delMod(tpz.mod.ATT, 7)
    target:delMod(tpz.mod.RATT, 7)
    target:delMod(tpz.mod.ACC, 7)
    target:delMod(tpz.mod.RACC, 7)
    target:delMod(tpz.mod.HPHEAL, 7)
    target:delMod(tpz.mod.MPHEAL, 7)
    target:delMod(tpz.mod.DEF, 7)
    target:delMod(tpz.mod.EVA, 7)
end
