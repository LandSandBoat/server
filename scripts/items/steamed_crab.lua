-----------------------------------
-- ID: 4342
-- Item: steamed_crab
-- Food Effect: 60Min, All Races
-----------------------------------
-- Vitality 3
-- Defense % 27 (cap 65)
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.FOOD_DEFP, 27)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 65)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
