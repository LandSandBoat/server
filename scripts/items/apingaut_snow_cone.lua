-----------------------------------
-- ID: 6224
-- Item: Apingaut snow cone
-- Food Effect: 30 Min, All Races
-----------------------------------
-- MP +25% (cap 105)
-- INT +6
-- MND +6
-- Magic Atk. Bonus +14
-- Lizard Killer +6
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
    effect:addMod(xi.mod.FOOD_MPP, 25)
    effect:addMod(xi.mod.FOOD_MP_CAP, 105)
    effect:addMod(xi.mod.INT, 6)
    effect:addMod(xi.mod.MND, 6)
    effect:addMod(xi.mod.MATT, 14)
    effect:addMod(xi.mod.LIZARD_KILLER, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
