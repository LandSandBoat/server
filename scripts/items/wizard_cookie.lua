-----------------------------------
-- ID: 4576
-- Item: wizard_cookie
-- Food Effect: 5Min, All Races
-----------------------------------
-- MP Recovered While Healing 7
-- Plantoid Killer 12
-- Slow Resist 12
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
    effect:addMod(xi.mod.MPHEAL, 7)
    effect:addMod(xi.mod.PLANTOID_KILLER, 12)
    effect:addMod(xi.mod.SLOWRES, 12)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
