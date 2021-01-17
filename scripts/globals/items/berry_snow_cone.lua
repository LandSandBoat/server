-----------------------------------------
-- ID: 5710
-- Item: Berry Snowcone
-- Food Effect: 5 Min, All Races
-----------------------------------------
-- MP % 30 Cap 30
-- Intelligence 1
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5710)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 30)
    target:addMod(tpz.mod.FOOD_MP_CAP, 30)
    target:addMod(tpz.mod.INT, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 30)
    target:delMod(tpz.mod.FOOD_MP_CAP, 30)
    target:delMod(tpz.mod.INT, 1)
end

return item_object
