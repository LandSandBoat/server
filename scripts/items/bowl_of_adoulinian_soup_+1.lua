-----------------------------------
-- ID: 5999
-- Item: Bowl of Adoulin Soup +1
-- Food Effect: 240 Min, All Races
-----------------------------------
-- HP % 4 Cap 45
-- Vitality 4
-- Defense % 16 Cap 75
-- HP Healing 7
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
    effect:addMod(xi.mod.FOOD_HPP, 4)
    effect:addMod(xi.mod.FOOD_HP_CAP, 45)
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.FOOD_DEFP, 16)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 75)
    effect:addMod(xi.mod.HPHEAL, 7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
