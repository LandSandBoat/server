-----------------------------------
-- ID: 5453
-- Item: Istakoz
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Dexterity -5
-- Vitality 3
-- Defense +16% (cap 50)
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
    effect:addMod(xi.mod.VIT, 3)
    effect:addMod(xi.mod.FOOD_DEFP, 16)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 50)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
