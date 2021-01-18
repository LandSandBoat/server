-----------------------------------
-- ID: 4335
-- Item: slice_of_juicy_mutton
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength 3
-- Intelligence -1
-- Attack % 27
-- Attack Cap 35
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4335)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.FOOD_ATTP, 27)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 35)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.FOOD_ATTP, 27)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 35)
end

return item_object
