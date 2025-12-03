-----------------------------------
-- ID: 5656
-- Item: coffeecake_muffin_+1
-- Food Effect: 1Hr, All Races
-----------------------------------
-- Mind 2
-- Strength -1
-- MP % 10 (cap 90)
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
    effect:addMod(xi.mod.MND, 2)
    effect:addMod(xi.mod.STR, -1)
    effect:addMod(xi.mod.FOOD_MPP, 10)
    effect:addMod(xi.mod.FOOD_MP_CAP, 90)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
