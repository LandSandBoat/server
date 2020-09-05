-----------------------------------------
-- ID: 5780
-- Item: coffee_macaron
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Increases rate of synthesis success +5%
-- Increases synthesis skill gain rate +5%
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5780)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.SYNTH_SUCCESS, 5)
    target:addMod(tpz.mod.SYNTH_SKILL_GAIN, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.SYNTH_SUCCESS, 5)
    target:delMod(tpz.mod.SYNTH_SKILL_GAIN, 5)
end
