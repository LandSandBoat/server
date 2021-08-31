-----------------------------------
-- ID: 4338
-- Item: steamed_crayfish
-- Food Effect: 60Min, All Races
-----------------------------------
-- Defense % 30
-- Defense Cap 30
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4338)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_DEFP, 30)
    target:addMod(xi.mod.FOOD_DEF_CAP, 30)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_DEFP, 30)
    target:delMod(xi.mod.FOOD_DEF_CAP, 30)
end

return item_object
