-----------------------------------
-- ID: 5751
-- Item: bowl_of_goulash_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- VIT +4
-- INT -2
-- Accuracy +11% (cap 58)
-- DEF +11% (cap 35)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5751)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.FOOD_ACCP, 11)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 58)
    target:addMod(tpz.mod.FOOD_DEFP, 11)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 35)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.FOOD_ACCP, 11)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 58)
    target:delMod(tpz.mod.FOOD_DEFP, 11)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 35)
end

return item_object
