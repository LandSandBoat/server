-----------------------------------
-- ID: 5711
-- Item: kitron_snow_cone
-- Food Effect: 5 Min, All Races
-----------------------------------
-- MP +15% (cap 15)
-- Intelligence 2
-- Wind resistance +5
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
    effect:addMod(xi.mod.FOOD_MPP, 15)
    effect:addMod(xi.mod.FOOD_MP_CAP, 15)
    effect:addMod(xi.mod.INT, 2)
    effect:addMod(xi.mod.WIND_MEVA, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
