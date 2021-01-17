-----------------------------------------
-- ID: 5660
-- Item: stick_of_pepperoni
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP % 3 (assuming 3% from testing, no known cap)
-- Strength 3
-- Intelligence -1
-- Attack % 60 (assuming 60%, cap 30)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5660)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 3)
    target:addMod(tpz.mod.FOOD_HP_CAP, 999)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 60)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 30)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 3)
    target:delMod(tpz.mod.FOOD_HP_CAP, 999)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 60)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 30)
end

return item_object
