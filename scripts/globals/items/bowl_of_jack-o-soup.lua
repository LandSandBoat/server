-----------------------------------------
-- ID: 4522
-- Item: Bowl of Jack-o'-Soup
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Health % 2 (cap 120)
-- Agility 3
-- Vitality -1
-- Health Regen While Healing 5
-- Ranged ACC % 8
-- Ranged ACC Cap 25
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4522)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 2)
    target:addMod(tpz.mod.FOOD_HP_CAP, 120)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.HPHEAL, 5)
    target:addMod(tpz.mod.FOOD_RACCP, 8)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 25)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 2)
    target:delMod(tpz.mod.FOOD_HP_CAP, 120)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.HPHEAL, 5)
    target:delMod(tpz.mod.FOOD_RACCP, 8)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 25)
end
