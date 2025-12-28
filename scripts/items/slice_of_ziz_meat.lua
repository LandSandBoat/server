-----------------------------------
-- ID: 5581
-- Item: Slice of Ziz Meat
-- Effect: 5 Minutes, food effect, Galka Only
-----------------------------------
-- Strength +4
-- Intelligence -6
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.RAW_MEAT)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 4)
    effect:addMod(xi.mod.INT, -6)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
