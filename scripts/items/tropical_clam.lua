-----------------------------------
-- ID: 5124
-- Item: Tropical Clam
-- Food Effect: 5Min, Mithra only
-----------------------------------
-- Vitality 4
-- Dexterity -5
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
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.DEX, -5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
