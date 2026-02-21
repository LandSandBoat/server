-----------------------------------
-- ID: 4508
-- Item: Serving of Royal Jelly
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- MP Recovery while healing 3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 10800, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
