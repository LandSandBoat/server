-----------------------------------
-- ID: 5626
-- Item: Silken Siesta
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP Recoverd while healing 2
-- MP Recovered while healing 5
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
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
