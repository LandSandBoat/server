-----------------------------------
-- ID: 4358
-- Hare Meat
-- 5 Minutes, food effect, Galka Only
-----------------------------------
-- Strength +1
-- Intelligence -3
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
    target:addMod(xi.mod.STR, 1)
    target:addMod(xi.mod.INT, -3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 1)
    target:delMod(xi.mod.INT, -3)
end

return itemObject
