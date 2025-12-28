-----------------------------------
-- ID: 4569
-- Item: Bowl of Quadav Stew
-- Food Effect: 180Min, All Races
-----------------------------------
-- Agility -4
-- Vitality 2
-- Defense % 17
-- Defense Cap 60
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
    effect:addMod(xi.mod.AGI, -4)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.FOOD_DEFP, 17)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 60)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
