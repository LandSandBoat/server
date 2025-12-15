-----------------------------------
-- ID: 5233
-- Item: cube_of_cotton_tofu
-- Food Effect: 5Min, All Races
-----------------------------------
-- Health % 10
-- Health Cap 30
-- Magic % 10
-- Magic Cap 30
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HPP, 10)
    effect:addMod(xi.mod.FOOD_HP_CAP, 30)
    effect:addMod(xi.mod.FOOD_MPP, 10)
    effect:addMod(xi.mod.FOOD_MP_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
