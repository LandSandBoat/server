-----------------------------------
-- ID: 4438
-- Item: dhalmel_steak
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 4
-- Intelligence -2
-- Attack % 25
-- Attack Cap 45
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4438)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.INT, -2)
    target:addMod(xi.mod.FOOD_ATTP, 25)
    target:addMod(xi.mod.FOOD_ATT_CAP, 45)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.INT, -2)
    target:delMod(xi.mod.FOOD_ATTP, 25)
    target:delMod(xi.mod.FOOD_ATT_CAP, 45)
end

return itemObject
