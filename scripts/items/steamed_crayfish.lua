-----------------------------------
-- ID: 4338
-- Item: steamed_crayfish
-- Food Effect: 60Min, All Races
-----------------------------------
-- Defense % 30
-- Defense Cap 30
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 3600, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_DEFP, 30)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 30)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
