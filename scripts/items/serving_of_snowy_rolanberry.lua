-----------------------------------
-- ID: 4594
-- Item: serving_of_snowy_rolanberry
-- Food Effect: 240Min, All Races
-----------------------------------
-- Magic % 19
-- Magic Cap 60
-- Intelligence 2
-- Wind Res 5
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
    effect:addMod(xi.mod.FOOD_MPP, 19)
    effect:addMod(xi.mod.FOOD_MP_CAP, 60)
    effect:addMod(xi.mod.INT, 2)
    effect:addMod(xi.mod.WIND_MEVA, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
