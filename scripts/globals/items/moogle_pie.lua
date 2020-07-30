-----------------------------------------
-- ID: 5561
-- Item: Moogle Pie
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- HP 20
-- MP 20
-- Strength 1
-- Dexterity 1
-- Vitality 1
-- Agility 1
-- Intelligence 1
-- Mind 1
-- Charisma 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5561)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 20)
    target:addMod(tpz.mod.MP, 20)
    target:addMod(tpz.mod.STR, 1)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.MND, 1)
    target:addMod(tpz.mod.CHR, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 20)
    target:delMod(tpz.mod.MP, 20)
    target:delMod(tpz.mod.STR, 1)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.MND, 1)
    target:delMod(tpz.mod.CHR, 1)
end
