-----------------------------------
-- ID: 4394
-- Item: ginger_cookie
-- Food Effect: 3Min, All Races
-----------------------------------
-- Magic Regen While Healing 5
-- Plantoid Killer 10
-- Slow Resist 10
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
    effect:addMod(xi.mod.MPHEAL, 5)
    effect:addMod(xi.mod.PLANTOID_KILLER, 10)
    effect:addMod(xi.mod.SLOWRES, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
