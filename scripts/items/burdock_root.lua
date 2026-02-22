-----------------------------------
-- ID: 5651
-- Item: Burdock Root
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility 2
-- Vitality -4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 300, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.VIT, -4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
