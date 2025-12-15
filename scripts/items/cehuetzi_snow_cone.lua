-----------------------------------
-- ID: 6223
-- Item: Cehuetzi snow cone
-- Food Effect: 30 Min, All Races
-----------------------------------
-- MP +20% (cap 100)
-- INT +5
-- MND +5
-- Magic Atk. Bonus +13
-- Lizard Killer +5
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
    effect:addMod(xi.mod.FOOD_MPP, 20)
    effect:addMod(xi.mod.FOOD_MP_CAP, 100)
    effect:addMod(xi.mod.INT, 5)
    effect:addMod(xi.mod.MND, 5)
    effect:addMod(xi.mod.MATT, 13)
    effect:addMod(xi.mod.LIZARD_KILLER, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
