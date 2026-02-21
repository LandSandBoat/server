-----------------------------------
-- ID: 4556
-- Item: serving_of_icecap_rolanberry
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic % 19
-- Magic Cap 55
-- Intelligence 2
-- Wind Res 5
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
    effect:addMod(xi.mod.FOOD_MPP, 19)
    effect:addMod(xi.mod.FOOD_MP_CAP, 55)
    effect:addMod(xi.mod.INT, 2)
    effect:addMod(xi.mod.WIND_MEVA, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
