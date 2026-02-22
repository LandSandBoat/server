-----------------------------------
-- ID: 5231
-- Item: truelove_chocolate
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- MP 10
-- MP Recovered While Healing 4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 14400, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.MPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
