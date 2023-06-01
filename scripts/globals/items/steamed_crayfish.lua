-----------------------------------
-- ID: 4338
-- Item: steamed_crayfish
-- Food Effect: 60Min, All Races
-----------------------------------
-- Defense % 30
-- Defense Cap 30
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4338)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_DEFP, 30)
    target:addMod(xi.mod.FOOD_DEF_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_DEFP, 30)
    target:delMod(xi.mod.FOOD_DEF_CAP, 30)
end

return itemObject
