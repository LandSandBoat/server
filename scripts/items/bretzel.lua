-----------------------------------
-- ID: 4391
-- Item: Bretzel
-- Food Effect: 3Min, All Races
-----------------------------------
-- Magic % 8
-- Magic Cap 55
-- Vitality 2
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_MPP, 8)
    effect:addMod(xi.mod.FOOD_MP_CAP, 55)
    effect:addMod(xi.mod.VIT, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
