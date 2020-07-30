-----------------------------------------
-- ID: 4327
-- Item: Bowl of Emerald Soup
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Agility 2
-- Vitality -1
-- Health Regen While Healing 3
-- Ranged ACC 6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4327)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 2)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.HPHEAL, 3)
    target:addMod(tpz.mod.RACC, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 2)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.HPHEAL, 3)
    target:delMod(tpz.mod.RACC, 6)
end
