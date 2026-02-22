-----------------------------------
-- ID: 4292
-- Item: loaf_of_pain_de_neige
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 18
-- Vitality 4
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
    effect:addMod(xi.mod.FOOD_HP, 18)
    effect:addMod(xi.mod.VIT, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
