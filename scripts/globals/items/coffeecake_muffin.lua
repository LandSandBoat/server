-----------------------------------
-- ID: 5655
-- Item: coffeecake_muffin
-- Food Effect: 30Min, All Races
-----------------------------------
-- Mind 1
-- Strength -1
-- MP % 10 (cap 85)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5655)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MND, 1)
    target:addMod(tpz.mod.STR, -1)
    target:addMod(tpz.mod.FOOD_MPP, 10)
    target:addMod(tpz.mod.FOOD_MP_CAP, 85)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MND, 1)
    target:delMod(tpz.mod.STR, -1)
    target:delMod(tpz.mod.FOOD_MPP, 10)
    target:delMod(tpz.mod.FOOD_MP_CAP, 85)
end

return item_object
