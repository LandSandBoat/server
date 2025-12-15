-----------------------------------
-- ID: 5623
-- Item: Dish of Spaghetti Tonno Rosso
-- Food Effect: 30 Mins, All Races
-----------------------------------
-- Health % 13
-- Health Cap 180
-- Dexterity 1
-- Vitality 2
-- Store TP +6
-- hMP +1
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
    effect:addMod(xi.mod.FOOD_HPP, 13)
    effect:addMod(xi.mod.FOOD_HP_CAP, 180)
    effect:addMod(xi.mod.DEX, 1)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.STORETP, 6)
    effect:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
