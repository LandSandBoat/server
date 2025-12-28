-----------------------------------
-- ID: 5642
-- Item: serving_of_cilbir
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- HP % 5 (cap 150)
-- MP % 5 (cap 100)
-- HP recovered while healing 3
-- MP recovered while healing 3
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
    effect:addMod(xi.mod.FOOD_HPP, 5)
    effect:addMod(xi.mod.FOOD_HP_CAP, 150)
    effect:addMod(xi.mod.FOOD_MPP, 5)
    effect:addMod(xi.mod.FOOD_MP_CAP, 100)
    effect:addMod(xi.mod.MPHEAL, 3)
    effect:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
