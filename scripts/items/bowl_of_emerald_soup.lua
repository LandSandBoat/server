-----------------------------------
-- ID: 4327
-- Item: Bowl of Emerald Soup
-- Food Effect: 240Min, All Races
-----------------------------------
-- Agility 2
-- Vitality -1
-- Health Regen While Healing 3
-- Ranged ACC 6
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.HPHEAL, 3)
    effect:addMod(xi.mod.RACC, 6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
