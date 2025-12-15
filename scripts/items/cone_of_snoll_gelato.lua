-----------------------------------
-- ID: 5147
-- Item: cone_of_snoll_gelato
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP % 16 (cap 75)
-- MP Recovered While Healing 1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_MPP, 16)
    effect:addMod(xi.mod.FOOD_MP_CAP, 75)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
