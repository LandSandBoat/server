-----------------------------------
-- ID: 5191
-- Item: dish_of_spaghetti_pescatora
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 15
-- Health Cap 150
-- Vitality 3
-- Mind -1
-- Defense % 22
-- Defense Cap 65
-- Store TP 6
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5191)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 15)
    target:addMod(xi.mod.FOOD_HP_CAP, 150)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_DEFP, 22)
    target:addMod(xi.mod.FOOD_DEF_CAP, 65)
    target:addMod(xi.mod.STORETP, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 15)
    target:delMod(xi.mod.FOOD_HP_CAP, 150)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_DEFP, 22)
    target:delMod(xi.mod.FOOD_DEF_CAP, 65)
    target:delMod(xi.mod.STORETP, 6)
end

return item_object
