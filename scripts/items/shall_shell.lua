-----------------------------------
-- ID: 4484
-- Item: shall_shell
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity -5
-- Vitality 4
-- Defense % 16.4
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
    effect:addMod(xi.mod.DEX, -5)
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.FOOD_DEFP, 16.4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
