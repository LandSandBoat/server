-----------------------------------------
-- ID: 4539
-- Item: goblin_pie
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 12
-- Magic 12
-- Dexterity -1
-- Agility 3
-- Vitality -1
-- Charisma -5
-- Defense % 9 (cap 100)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4539)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 12)
    target:addMod(tpz.mod.MP, 12)
    target:addMod(tpz.mod.DEX, -1)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.CHR, -5)
    target:addMod(tpz.mod.FOOD_DEFP, 9)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 100)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 12)
    target:delMod(tpz.mod.MP, 12)
    target:delMod(tpz.mod.DEX, -1)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.CHR, -5)
    target:delMod(tpz.mod.FOOD_DEFP, 9)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 100)
end
