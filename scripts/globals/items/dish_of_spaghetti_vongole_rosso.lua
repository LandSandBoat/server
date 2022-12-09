-----------------------------------
-- ID: 5189
-- Item: dish_of_spaghetti_vongole_rosso
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 20
-- Health Cap 90
-- Vitality 2
-- Mind -1
-- Defense % 25
-- Defense Cap 30
-- Store TP 6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5189)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 20)
    target:addMod(xi.mod.FOOD_HP_CAP, 90)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 30)
    target:addMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 20)
    target:delMod(xi.mod.FOOD_HP_CAP, 90)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 30)
    target:delMod(xi.mod.STORETP, 6)
end

return itemObject
