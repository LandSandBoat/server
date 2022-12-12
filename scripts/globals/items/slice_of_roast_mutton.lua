-----------------------------------
-- ID: 4437
-- Item: slice_of_roast_mutton
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 3
-- Intelligence -1
-- Attack % 27
-- Attack Cap 30
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4437)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 3)
    target:addMod(xi.mod.INT, -1)
    target:addMod(xi.mod.FOOD_ATTP, 27)
    target:addMod(xi.mod.FOOD_ATT_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 3)
    target:delMod(xi.mod.INT, -1)
    target:delMod(xi.mod.FOOD_ATTP, 27)
    target:delMod(xi.mod.FOOD_ATT_CAP, 30)
end

return itemObject
