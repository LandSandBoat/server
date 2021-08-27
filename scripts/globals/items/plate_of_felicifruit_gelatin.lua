-----------------------------------
-- ID: 5978
-- Item: Plate of Felicifruit Gelatin
-- Food Effect: 180 Min, All Races
-----------------------------------
-- MP % 5 Cap 100
-- Intelligence +7
-- MP Healing +3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5978)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 5)
    target:addMod(xi.mod.FOOD_MP_CAP, 100)
    target:addMod(xi.mod.INT, 7)
    target:addMod(xi.mod.MPHEAL, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 5)
    target:delMod(xi.mod.FOOD_MP_CAP, 100)
    target:delMod(xi.mod.INT, 7)
    target:delMod(xi.mod.MPHEAL, 3)
end

return item_object
