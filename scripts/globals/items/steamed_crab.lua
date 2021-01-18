-----------------------------------
-- ID: 4342
-- Item: steamed_crab
-- Food Effect: 60Min, All Races
-----------------------------------
-- Vitality 3
-- Defense % 27 (cap 65)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4342)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.FOOD_DEFP, 27)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 65)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.FOOD_DEFP, 27)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 65)
end

return item_object
