-----------------------------------
-- ID: 5233
-- Item: cube_of_cotton_tofu
-- Food Effect: 5Min, All Races
-----------------------------------
-- Health % 10
-- Health Cap 30
-- Magic % 10
-- Magic Cap 30
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5233)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 10)
    target:addMod(tpz.mod.FOOD_HP_CAP, 30)
    target:addMod(tpz.mod.FOOD_MPP, 10)
    target:addMod(tpz.mod.FOOD_MP_CAP, 30)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 10)
    target:delMod(tpz.mod.FOOD_HP_CAP, 30)
    target:delMod(tpz.mod.FOOD_MPP, 10)
    target:delMod(tpz.mod.FOOD_MP_CAP, 30)
end

return item_object
