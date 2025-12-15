-----------------------------------
-- ID: 5556
-- Item: cone_of_seraphs_kiss
-- Food Effect: 1Hr, All Races
-----------------------------------
-- HP 15
-- MP % 16 (cap 85)
-- MP Recovered While Healing 2
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
    effect:addMod(xi.mod.FOOD_HP, 15)
    effect:addMod(xi.mod.FOOD_MPP, 16)
    effect:addMod(xi.mod.FOOD_MP_CAP, 85)
    effect:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
