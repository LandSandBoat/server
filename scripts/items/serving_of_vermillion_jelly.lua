-----------------------------------
-- ID: 5158
-- Item: Vermillion Jelly
-- Food Effect: 4 hours, All Races
-----------------------------------
-- MP +12%(Cap: 90@750 Base MP)
-- Intelligence +6
-- MP Recovered While Healing +2
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
    effect:addMod(xi.mod.FOOD_MPP, 12)
    effect:addMod(xi.mod.FOOD_MP_CAP, 90)
    effect:addMod(xi.mod.INT, 6)
    effect:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
