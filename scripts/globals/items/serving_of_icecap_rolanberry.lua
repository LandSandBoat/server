-----------------------------------
-- ID: 4556
-- Item: serving_of_icecap_rolanberry
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic % 19
-- Magic Cap 55
-- Intelligence 2
-- Wind Res 5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4556)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 19)
    target:addMod(xi.mod.FOOD_MP_CAP, 55)
    target:addMod(xi.mod.INT, 2)
    target:addMod(xi.mod.WIND_RES, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 19)
    target:delMod(xi.mod.FOOD_MP_CAP, 55)
    target:delMod(xi.mod.INT, 2)
    target:delMod(xi.mod.WIND_RES, 5)
end

return item_object
