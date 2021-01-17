-----------------------------------------
-- ID: 5639
-- Item: Skewer of M&P Chicken
-- Food Effect: 3Min, All Races
-----------------------------------------
-- Strength 5
-- Intelligence -5
-- Attack % 25
-- Attack Cap 154
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 5639)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 5)
    target:addMod(tpz.mod.INT, -5)
    target:addMod(tpz.mod.FOOD_ATTP, 25)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 154)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 5)
    target:delMod(tpz.mod.INT, -5)
    target:delMod(tpz.mod.FOOD_ATTP, 25)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 154)
end

return item_object
