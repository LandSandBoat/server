-----------------------------------------
-- ID: 5683
-- Item: humpty_dumpty_effigy
-- Food Effect: 3 hours, All Races
-----------------------------------------
-- Max HP % 6 (cap 160)
-- Max MP % 6 (cap 160)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5683)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 6)
    target:addMod(tpz.mod.FOOD_HP_CAP, 160)
    target:addMod(tpz.mod.FOOD_MPP, 6)
    target:addMod(tpz.mod.FOOD_MP_CAP, 160)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 6)
    target:delMod(tpz.mod.FOOD_HP_CAP, 160)
    target:delMod(tpz.mod.FOOD_MPP, 6)
    target:delMod(tpz.mod.FOOD_MP_CAP, 160)
end

return item_object
