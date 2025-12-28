-----------------------------------
-- ID: 4472
-- Item: crayfish
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity -3
-- Vitality 1
-- defense +10% (unknown cap)
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
    effect:addMod(xi.mod.DEX, -3)
    effect:addMod(xi.mod.VIT, 1)
    effect:addMod(xi.mod.FOOD_DEFP, 10)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
