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
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HPP, 25)
    effect:addMod(xi.mod.FOOD_HP_CAP, 105)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.STORETP, 6)
    effect:addMod(xi.mod.SLEEPRES, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
