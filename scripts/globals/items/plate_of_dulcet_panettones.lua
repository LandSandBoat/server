-----------------------------------
-- ID: 5979
-- Item: Plate of Dulcet Panettones
-- Food Effect: 240 Min, All Races
-----------------------------------
-- MP % 6 Cap 105
-- Intelligence +8
-- MP Healing +4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5979)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 6)
    target:addMod(tpz.mod.FOOD_MP_CAP, 105)
    target:addMod(tpz.mod.INT, 8)
    target:addMod(tpz.mod.MPHEAL, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 6)
    target:delMod(tpz.mod.FOOD_MP_CAP, 105)
    target:delMod(tpz.mod.INT, 8)
    target:delMod(tpz.mod.MPHEAL, 4)
end

return item_object
