-----------------------------------
-- ID: 5675
-- Item: Withered Rolanberry
-- Food Effect: 30 Mins, All Races
-----------------------------------
-- Intelligence 1
-- Agility -3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 1800, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.INT, 1)
    effect:addMod(xi.mod.AGI, -3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
