-----------------------------------
-- ID: 4443
-- Item: cobalt_jellyfish
-- Food Effect: 5 Min, Mithra only
-----------------------------------
-- Dexterity 1
-- Mind -3
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
    effect:addMod(xi.mod.DEX, 1)
    effect:addMod(xi.mod.MND, -3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
