-----------------------------------
-- ID: 5998
-- Item: Bowl of Adoulin Soup
-- Food Effect: 180 Min, All Races
-----------------------------------
-- HP % 3 Cap 40
-- Vitality 3
-- Defense % 15 Cap 70
-- HP Healing 6
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HPP, 3)
    effect:addMod(xi.mod.FOOD_HP_CAP, 40)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.FOOD_DEFP, 15)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 70)
    effect:addMod(xi.mod.HPHEAL, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
