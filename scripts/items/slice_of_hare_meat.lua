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
    target:addStatusEffect(xi.effect.FOOD, { duration = 300, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, 1)
    effect:addMod(xi.mod.INT, -3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
