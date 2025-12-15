-----------------------------------
-- ID: 5650
-- Item: pair_of_nopales
-- Food Effect: 5min, All Races
-----------------------------------
-- VIT -4
-- AGI +2
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
    effect:addMod(xi.mod.VIT, -4)
    effect:addMod(xi.mod.AGI, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
