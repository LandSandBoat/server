-----------------------------------------
-- ID: 5685
-- Item: rabbit_pie
-- Food Effect: 30minutes, All Races
-----------------------------------------
-- Strength 5
-- Vitality 5
-- Attack 25% (caps @ 100)
-- Ranged Attack 25% (caps @ 100)
-- Defense 25% (caps @ 100)
-- Intelligence -2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5685)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 5)
    target:addMod(tpz.mod.VIT, 5)
    target:addMod(tpz.mod.FOOD_ATTP, 25)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 100)
    target:addMod(tpz.mod.FOOD_RATTP, 25)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 100)
    target:addMod(tpz.mod.FOOD_DEFP, 25)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 100)
    target:addMod(tpz.mod.INT, -2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 5)
    target:delMod(tpz.mod.VIT, 5)
    target:delMod(tpz.mod.FOOD_ATTP, 25)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 100)
    target:delMod(tpz.mod.FOOD_RATTP, 25)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 100)
    target:delMod(tpz.mod.FOOD_DEFP, 25)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 100)
    target:delMod(tpz.mod.INT, -2)
end

return item_object
