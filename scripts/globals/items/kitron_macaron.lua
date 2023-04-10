-----------------------------------
-- ID: 5781
-- Item: kitron_macaron
-- Food Effect: 30Min, All Races
-----------------------------------
-- Increases rate of synthesis success +7%
-- Increases synthesis skill gain rate +7%
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5781)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SYNTH_SUCCESS, 7)
    target:addMod(xi.mod.SYNTH_SKILL_GAIN, 7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SYNTH_SUCCESS, 7)
    target:delMod(xi.mod.SYNTH_SKILL_GAIN, 7)
end

return itemObject
