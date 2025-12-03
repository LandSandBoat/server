-----------------------------------
-- ID: 4567
-- Item: moon_carrot
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility 1
-- Vitality -1
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
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.VIT, -1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
