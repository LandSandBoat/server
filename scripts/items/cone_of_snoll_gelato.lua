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
    target:addMod(xi.mod.FOOD_MPP, 16)
    target:addMod(xi.mod.FOOD_MP_CAP, 75)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 16)
    target:delMod(xi.mod.FOOD_MP_CAP, 75)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
