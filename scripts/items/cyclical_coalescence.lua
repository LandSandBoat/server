-----------------------------------
-- ID: 6225
-- Item: Cyclical coalescence
-- Food Effect: 30 Min, All Races
-----------------------------------
-- MP +30% (cap 110)
-- INT +7
-- MND +7
-- Magic Atk. Bonus +15
-- Lizard Killer +7
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
    effect:addMod(xi.mod.FOOD_MPP, 30)
    effect:addMod(xi.mod.FOOD_MP_CAP, 110)
    effect:addMod(xi.mod.INT, 7)
    effect:addMod(xi.mod.MND, 7)
    effect:addMod(xi.mod.MATT, 15)
    effect:addMod(xi.mod.LIZARD_KILLER, 7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
