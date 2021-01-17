-----------------------------------------
-- ID: 5998
-- Item: Bowl of Adoulin Soup
-- Food Effect: 180 Min, All Races
-----------------------------------------
-- HP % 3 Cap 40
-- Vitality 3
-- Defense % 15 Cap 70
-- HP Healing 6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5998)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 3)
    target:addMod(tpz.mod.FOOD_HP_CAP, 40)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.FOOD_DEFP, 15)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 70)
    target:addMod(tpz.mod.HPHEAL, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 3)
    target:delMod(tpz.mod.FOOD_HP_CAP, 40)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.FOOD_DEFP, 15)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 70)
    target:delMod(tpz.mod.HPHEAL, 6)
end

return item_object
