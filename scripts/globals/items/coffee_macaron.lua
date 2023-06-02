-----------------------------------
-- ID: 5780
-- Item: coffee_macaron
-- Food Effect: 30Min, All Races
-----------------------------------
-- Increases rate of synthesis success +5%
-- Increases synthesis skill gain rate +5%
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5780)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.SYNTH_SUCCESS, 5)
    target:addMod(xi.mod.SYNTH_SKILL_GAIN, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.SYNTH_SUCCESS, 5)
    target:delMod(xi.mod.SYNTH_SKILL_GAIN, 5)
end

return itemObject
