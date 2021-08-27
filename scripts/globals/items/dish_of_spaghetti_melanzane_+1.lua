-----------------------------------
-- ID: 5214
-- Item: dish_of_spaghetti_melanzane_+1
-- Food Effect: 1Hr, All Races
-----------------------------------
-- HP % 25 (cap 105)
-- Vitality 2
-- Store TP 6
-- Resist sleep 10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5214)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 25)
    target:addMod(xi.mod.FOOD_HP_CAP, 105)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.STORETP, 6)
    target:addMod(xi.mod.SLEEPRES, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 25)
    target:delMod(xi.mod.FOOD_HP_CAP, 105)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.STORETP, 6)
    target:delMod(xi.mod.SLEEPRES, 10)
end

return item_object
