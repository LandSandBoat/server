-----------------------------------------
-- ID: 4592
-- Item: bowl_of_wisdom_soup
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- HP 3
-- MP 3
-- Strength 1
-- Dexterity 1
-- Agility 1
-- Vitality 1
-- Intelligence 1
-- Mind 1
-- Charisma 1
-- HP Recovered While Healing 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4592)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 3)
    target:addMod(tpz.mod.MP, 3)
    target:addMod(tpz.mod.STR, 1)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.MND, 1)
    target:addMod(tpz.mod.CHR, 1)
    target:addMod(tpz.mod.HPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 3)
    target:delMod(tpz.mod.MP, 3)
    target:delMod(tpz.mod.STR, 1)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.MND, 1)
    target:delMod(tpz.mod.CHR, 1)
    target:delMod(tpz.mod.HPHEAL, 3)
end
