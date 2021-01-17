-----------------------------------------
-- ID: 5182
-- Item: salty_bretzel
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Magic % 8
-- Magic Cap 60
-- Vitality 2
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5182)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 8)
    target:addMod(tpz.mod.FOOD_MP_CAP, 60)
    target:addMod(tpz.mod.VIT, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 8)
    target:delMod(tpz.mod.FOOD_MP_CAP, 60)
    target:delMod(tpz.mod.VIT, 2)
end

return item_object
