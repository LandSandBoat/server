-----------------------------------
-- ID: 5720
-- Item: dish_of_spaghetti_marinara_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP % 15 (cap 130)
-- Vitality 2
-- Defense 6
-- Store TP 6
-- hHP +1
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
    effect:addMod(xi.mod.FOOD_HPP, 15)
    effect:addMod(xi.mod.FOOD_HP_CAP, 130)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.DEF, 6)
    effect:addMod(xi.mod.STORETP, 6)
    effect:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
