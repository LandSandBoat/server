-----------------------------------------
-- ID: 5618
-- Item: bowl_of_zoni_broth
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- HP 10
-- MP 10
-- Strength 1
-- Dexterity 1
-- Vitality 1
-- Agility 1
-- Accuracy +1
-- Ranged Accuracy +1
-- Attack +1
-- Ranged Attack +1
-- Evasion +1
-- HP Recovered While Healing 1
-- MP Recovered While Healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5618)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.STR, 1)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.ACC, 1)
    target:addMod(tpz.mod.RACC, 1)
    target:addMod(tpz.mod.ATT, 1)
    target:addMod(tpz.mod.RATT, 1)
    target:addMod(tpz.mod.EVA, 1)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.STR, 1)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.ACC, 1)
    target:delMod(tpz.mod.RACC, 1)
    target:delMod(tpz.mod.ATT, 1)
    target:delMod(tpz.mod.RATT, 1)
    target:delMod(tpz.mod.EVA, 1)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.MPHEAL, 1)
end
