-----------------------------------------
-- ID: 5711
-- Item: kitron_snow_cone
-- Food Effect: 5 Min, All Races
-----------------------------------------
-- MP +15% (cap 15)
-- Intelligence 2
-- Wind resistance +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5711)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 15)
    target:addMod(tpz.mod.FOOD_MP_CAP, 15)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.WINDRES, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 15)
    target:delMod(tpz.mod.FOOD_MP_CAP, 15)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.WINDRES, 5)
end

return item_object
