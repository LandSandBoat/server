-----------------------------------
-- ID: 5182
-- Item: salty_bretzel
-- Food Effect: 5Min, All Races
-----------------------------------
-- Magic % 8
-- Magic Cap 60
-- Vitality 2
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
    effect:addMod(xi.mod.FOOD_MPP, 8)
    effect:addMod(xi.mod.FOOD_MP_CAP, 60)
    effect:addMod(xi.mod.VIT, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
