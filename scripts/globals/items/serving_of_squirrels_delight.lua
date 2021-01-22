-----------------------------------
-- ID: 5554
-- Item: serving_of_squirrels_delight
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- MP % 13 (cap 95)
-- MP Recovered While Healing 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5554)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 13)
    target:addMod(tpz.mod.FOOD_MP_CAP, 95)
    target:addMod(tpz.mod.MPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 13)
    target:delMod(tpz.mod.FOOD_MP_CAP, 95)
    target:delMod(tpz.mod.MPHEAL, 2)
end

return item_object
