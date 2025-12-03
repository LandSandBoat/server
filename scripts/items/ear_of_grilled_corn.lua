-----------------------------------
-- ID: 4334
-- Item: ear_of_grilled_corn
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 10
-- Vitality 4
-- Health Regen While Healing 1
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
    effect:addMod(xi.mod.FOOD_HP, 10)
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
