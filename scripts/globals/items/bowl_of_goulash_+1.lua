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
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5751)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 4)
    target:addMod(xi.mod.INT, -2)
    target:addMod(xi.mod.FOOD_ACCP, 11)
    target:addMod(xi.mod.FOOD_ACC_CAP, 58)
    target:addMod(xi.mod.FOOD_DEFP, 11)
    target:addMod(xi.mod.FOOD_DEF_CAP, 35)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 4)
    target:delMod(xi.mod.INT, -2)
    target:delMod(xi.mod.FOOD_ACCP, 11)
    target:delMod(xi.mod.FOOD_ACC_CAP, 58)
    target:delMod(xi.mod.FOOD_DEFP, 11)
    target:delMod(xi.mod.FOOD_DEF_CAP, 35)
end

return itemObject
