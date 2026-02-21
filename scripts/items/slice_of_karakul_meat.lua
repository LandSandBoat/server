-----------------------------------
-- ID: 5571
-- Item: Slice of Karakul Meat
-- Effect: 5 Minutes, food effect, Galka Only
-----------------------------------
-- Strength +2
-- Intelligence -4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_MEAT)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 300, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 2)
    effect:addMod(xi.mod.INT, -4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
