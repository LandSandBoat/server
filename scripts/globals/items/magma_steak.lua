-----------------------------------------
-- ID: 6071
-- Item: Magma Steak
-- Food Effect: 180 Min, All Races
-----------------------------------------
-- Strength +8
-- Attack +23% Cap 180
-- Ranged Attack +23% Cap 180
-- Vermin Killer +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 6071)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 8)
    target:addMod(tpz.mod.FOOD_ATTP, 23)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 180)
    target:addMod(tpz.mod.FOOD_RATTP, 23)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 180)
    target:addMod(tpz.mod.VERMIN_KILLER, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 8)
    target:delMod(tpz.mod.FOOD_ATTP, 23)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 180)
    target:delMod(tpz.mod.FOOD_RATTP, 23)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 180)
    target:delMod(tpz.mod.VERMIN_KILLER, 5)
end

return item_object
