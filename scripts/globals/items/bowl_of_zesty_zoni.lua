-----------------------------------------
-- ID: 5619
-- Item: Bowl of Zesti Zoni
-- Food Effect: 4 Hrs, All Races
-----------------------------------------
-- HP 12
-- MP 12
-- Strength 2
-- Dexterity 2
-- Vitality 2
-- Agility 2
-- Accuracy +2
-- Ranged Accuracy +2
-- Attack +2
-- Ranged Attack +2
-- Evasion +2
-- MP Recovered while healing 1
-- HP Recovered while healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5619)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 12)
    target:addMod(tpz.mod.MP, 12)
    target:addMod(tpz.mod.STR, 2)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.ACC, 2)
    target:addMod(tpz.mod.RACC, 2)
    target:addMod(tpz.mod.ATT, 2)
    target:addMod(tpz.mod.RATT, 2)
    target:addMod(tpz.mod.EVA, 2)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 12)
    target:delMod(tpz.mod.MP, 12)
    target:delMod(tpz.mod.STR, 2)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.ACC, 2)
    target:delMod(tpz.mod.RACC, 2)
    target:delMod(tpz.mod.ATT, 2)
    target:delMod(tpz.mod.RATT, 2)
    target:delMod(tpz.mod.EVA, 2)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.MPHEAL, 1)
end
