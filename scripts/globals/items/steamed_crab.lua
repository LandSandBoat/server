-----------------------------------
-- ID: 4342
-- Item: steamed_crab
-- Food Effect: 60Min, All Races
-----------------------------------
-- Vitality 3
-- Defense % 27 (cap 65)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4342)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.FOOD_DEFP, 27)
    target:addMod(xi.mod.FOOD_DEF_CAP, 65)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.FOOD_DEFP, 27)
    target:delMod(xi.mod.FOOD_DEF_CAP, 65)
end

return itemObject
