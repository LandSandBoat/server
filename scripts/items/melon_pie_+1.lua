-----------------------------------
-- ID: 4523
-- Item: melon_pie_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Magic 30
-- Intelligence 5
-- Magic Regen While Healing 2
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
    effect:addMod(xi.mod.FOOD_MP, 30)
    effect:addMod(xi.mod.INT, 5)
    effect:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
