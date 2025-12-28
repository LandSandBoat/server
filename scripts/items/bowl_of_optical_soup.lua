-----------------------------------
-- ID: 4340
-- Item: bowl_of_optical_soup
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP % 6 (cap 75)
-- Charisma -15
-- HP Recovered While Healing 5
-- Accuracy 15
-- Ranged Accuracy 15
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HPP, 6)
    effect:addMod(xi.mod.FOOD_HP_CAP, 75)
    effect:addMod(xi.mod.CHR, -15)
    effect:addMod(xi.mod.HPHEAL, 5)
    effect:addMod(xi.mod.ACC, 15)
    effect:addMod(xi.mod.RACC, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
