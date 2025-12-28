-----------------------------------
-- ID: 5677
-- Item: Serving of Patriarch Sautee
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- MP 65
-- Mind 7
-- MP Recovered While Healing 7
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
    effect:addMod(xi.mod.FOOD_MP, 65)
    effect:addMod(xi.mod.MND, 7)
    effect:addMod(xi.mod.MPHEAL, 7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
