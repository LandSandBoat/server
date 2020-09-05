-----------------------------------------
-- ID: 5943
-- Item: Strip of Smoked Mackerel
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Agility 4
-- Vitality -3
-- Evasion +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5943)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 4)
    target:addMod(tpz.mod.VIT, -3)
    target:addMod(tpz.mod.EVA, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 4)
    target:delMod(tpz.mod.VIT, -3)
    target:delMod(tpz.mod.EVA, 5)
end
