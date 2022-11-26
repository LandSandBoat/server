-----------------------------------
-- ID: 5719
-- Item: dish_of_spaghetti_marinara
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP % 15 (cap 120)
-- Vitality 2
-- Defense 5
-- Store TP 6
-- hHP +1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5719)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 15)
    target:addMod(xi.mod.FOOD_HP_CAP, 120)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.DEF, 5)
    target:addMod(xi.mod.STORETP, 6)
    target:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 15)
    target:delMod(xi.mod.FOOD_HP_CAP, 120)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.DEF, 5)
    target:delMod(xi.mod.STORETP, 6)
    target:delMod(xi.mod.HPHEAL, 1)
end

return itemObject
