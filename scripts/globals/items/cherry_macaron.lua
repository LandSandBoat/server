-----------------------------------
-- ID: 5779
-- Item: cherry_macaron
-- Food Effect: 30Min, All Races
-----------------------------------
-- Increases rate of synthesis success +3%
-- Increases synthesis skill gain rate +3%
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5779)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.SYNTH_SUCCESS, 3)
    target:addMod(tpz.mod.SYNTH_SKILL_GAIN, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.SYNTH_SUCCESS, 3)
    target:delMod(tpz.mod.SYNTH_SKILL_GAIN, 3)
end

return item_object
