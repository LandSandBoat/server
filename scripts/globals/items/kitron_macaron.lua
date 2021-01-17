-----------------------------------------
-- ID: 5781
-- Item: kitron_macaron
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Increases rate of synthesis success +7%
-- Increases synthesis skill gain rate +7%
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5781)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.SYNTH_SUCCESS, 7)
    target:addMod(tpz.mod.SYNTH_SKILL_GAIN, 7)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.SYNTH_SUCCESS, 7)
    target:delMod(tpz.mod.SYNTH_SKILL_GAIN, 7)
end

return item_object
