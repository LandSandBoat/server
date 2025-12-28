-----------------------------------
-- ID: 4400
-- Item: slice_of_land_crab_meat
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity -4
-- Vitality 3
-- Defense % 14
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_FISH)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, -4)
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.FOOD_DEFP, 14)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
