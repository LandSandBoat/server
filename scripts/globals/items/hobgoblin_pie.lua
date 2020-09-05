-----------------------------------------
-- ID: 4325
-- Item: hobgoblin_pie
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 15
-- Magic 15
-- Agility 4
-- Charisma -7
-- Health Regen While Healing 2
-- Defense % 12 (cap 60)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4325)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 15)
    target:addMod(tpz.mod.MP, 15)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.CHR, -7)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.FOOD_DEFP, 12)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 60)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 15)
    target:delMod(tpz.mod.MP, 15)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.CHR, -7)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.FOOD_DEFP, 12)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 60)
end
